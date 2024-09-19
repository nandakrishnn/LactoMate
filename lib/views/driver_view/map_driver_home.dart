import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'dart:math' as math;

class MapboxMapWidget extends StatefulWidget {
  final List<Map<String, dynamic>> routeDetails;

  MapboxMapWidget({required this.routeDetails});

  @override
  _MapboxMapWidgetState createState() => _MapboxMapWidgetState();
}

class _MapboxMapWidgetState extends State<MapboxMapWidget> {
  late MapboxMapController _controller;
  LatLng? currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

    Location location = Location();
    location.onLocationChanged.listen((LocationData currentLocationData) {
      setState(() {
        currentLocation = LatLng(currentLocationData.latitude!, currentLocationData.longitude!);
      });
      _addCurrentLocationMarker();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MapboxMap(
      accessToken: 'pk.eyJ1IjoibmFuZGFrcmlzaG5uIiwiYSI6ImNtMHpwZzkxcTA4eHoyaXF0cmU5Znh0bHYifQ.AxCRb6R-j52fETy4rq37cg',
      styleString: 'mapbox://styles/mapbox/streets-v11',
      initialCameraPosition: _initialCameraPosition(),
      onMapCreated: (MapboxMapController controller) async {
        _controller = controller;
        final Uint8List markerImage = await loadAssetImage('assets/png-transparent-google-maps-pin-bing-maps-mapquest-map-map-location-red-removebg-preview.png');
        await _controller.addImage('custom-marker', markerImage);
        final Uint8List currentLocationMarkerImage = await loadAssetImage('assets/current-location-2-removebg-preview.png');
        await _controller.addImage('current-location-icon', currentLocationMarkerImage);

        if (currentLocation != null) {
          _addCurrentLocationMarker();
        }

        // Show route markers
        _showRouteMarkers();
      },
    );
  }

  CameraPosition _initialCameraPosition() {
    if (currentLocation != null) {
      return CameraPosition(target: currentLocation!, zoom: 12.0);
    } else if (widget.routeDetails.isNotEmpty) {
      final firstLocation = widget.routeDetails.first;
      return CameraPosition(target: LatLng(firstLocation['Latitude'], firstLocation['Longitude']), zoom: 12.0);
    }
    return CameraPosition(target: LatLng(10.8505, 76.2711), zoom: 12.0);
  }

  Future<Uint8List> loadAssetImage(String assetPath) async {
    final ByteData byteData = await rootBundle.load(assetPath);
    return byteData.buffer.asUint8List();
  }

  Future<void> _getCurrentLocation() async {
    final location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    if (permissionGranted == PermissionStatus.granted) {
      final userLocation = await location.getLocation();
      setState(() {
        currentLocation = LatLng(userLocation.latitude!, userLocation.longitude!);
        if (_controller != null && currentLocation != null) {
          _controller.animateCamera(CameraUpdate.newLatLng(currentLocation!));
          _addCurrentLocationMarker();
        }
      });
    }
  }

  Future<void> _addCurrentLocationMarker() async {
    if (currentLocation != null) {
      await _controller.addSymbol(SymbolOptions(
        geometry: currentLocation!,
        iconImage: 'current-location-icon',
        iconSize: 0.8,
        textField: 'You are here',
        textOffset: Offset(0, 1.5),
        textSize: 10.0,
        textColor: "#FF0000",
      ));
      _controller.animateCamera(CameraUpdate.newLatLng(currentLocation!));
    }
  }

  double _calculateDistance(LatLng point1, LatLng point2) {
    const R = 6371e3; // Radius of the Earth in meters
    final lat1Rad = point1.latitude * (math.pi / 180);
    final lat2Rad = point2.latitude * (math.pi / 180);
    final deltaLat = (point2.latitude - point1.latitude) * (math.pi / 180);
    final deltaLng = (point2.longitude - point1.longitude) * (math.pi / 180);

    final a = math.sin(deltaLat / 2) * math.sin(deltaLat / 2) +
        math.cos(lat1Rad) * math.cos(lat2Rad) *
            math.sin(deltaLng / 2) * math.sin(deltaLng / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return R * c; // Distance in meters
  }

  Future<void> _showRouteMarkers() async {
    if (currentLocation == null) {
      await _getCurrentLocation();
    }

    // Sort the shops based on proximity to the current location
    List<Map<String, dynamic>> sortedShops = widget.routeDetails;
    sortedShops.sort((a, b) {
      LatLng shopA = LatLng(a['Latitude'], a['Longitude']);
      LatLng shopB = LatLng(b['Latitude'], b['Longitude']);
      double distanceA = _calculateDistance(currentLocation!, shopA);
      double distanceB = _calculateDistance(currentLocation!, shopB);
      return distanceA.compareTo(distanceB);
    });

    // Add markers for sorted shops and draw the route
    List<LatLng> routePoints = [currentLocation!];
    for (var shop in sortedShops) {
      LatLng shopLocation = LatLng(shop['Latitude'], shop['Longitude']);
      routePoints.add(shopLocation);
      await _controller.addSymbol(SymbolOptions(
        geometry: shopLocation,
        iconImage: 'custom-marker',
        iconSize: 0.3,
        textField: shop['ShopAddress'] ?? '',
        textOffset: Offset(0, 1.5),
        textSize: 8.0,
        textColor: "#000000",
      ));
    }

    final routeGeometry = await _fetchRouteGeometry(routePoints);
    if (routeGeometry != null) {
      await _controller.addLine(LineOptions(
        geometry: routeGeometry,
        lineColor: "#FF0000",
        lineWidth: 3.0,
      ));
    } else {
      print('Failed to fetch route geometry');
    }
  }

  Future<List<LatLng>?> _fetchRouteGeometry(List<LatLng> waypoints) async {
    const apiKey = 'pk.eyJ1IjoibmFuZGFrcmlzaG5uIiwiYSI6ImNtMHpwZzkxcTA4eHoyaXF0cmU5Znh0bHYifQ.AxCRb6R-j52fETy4rq37cg';
    final coordinates = waypoints.map((latLng) => '${latLng.longitude},${latLng.latitude}').join(';');
    final url = 'https://api.mapbox.com/directions/v5/mapbox/driving/$coordinates?geometries=geojson&access_token=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final geometry = data['routes'][0]['geometry']['coordinates'];
        return geometry.map<LatLng>((coord) => LatLng(coord[1], coord[0])).toList();
      } else {
        print("Failed to fetch route data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching route data: $e");
    }
    return null;
  }
}
