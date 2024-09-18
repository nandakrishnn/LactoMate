import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

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
    _getCurrentLocation(); // Fetch the current location when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return MapboxMap(
      accessToken: 'pk.eyJ1IjoibmFuZGFrcmlzaG5uIiwiYSI6ImNtMHpwZzkxcTA4eHoyaXF0cmU5Znh0bHYifQ.AxCRb6R-j52fETy4rq37cg',
      styleString: 'mapbox://styles/mapbox/streets-v11',
      initialCameraPosition: _initialCameraPosition(),
      onMapCreated: (MapboxMapController controller) async {
        _controller = controller;

        // Load custom marker image
        final Uint8List markerImage = await loadAssetImage(
            'assets/png-transparent-google-maps-pin-bing-maps-mapquest-map-map-location-red-removebg-preview.png');

        // Add the marker image to the map
        await _controller.addImage('custom-marker', markerImage);

        // Show route markers
        _showRouteMarkers();

        // If current location is available, add it to the map
        if (currentLocation != null) {
          _addCurrentLocationMarker();
        }
      },
    );
  }

  CameraPosition _initialCameraPosition() {
    if (currentLocation != null) {
      return CameraPosition(
        target: currentLocation!,
        zoom: 12.0,
      );
    } else if (widget.routeDetails.isNotEmpty) {
      final firstLocation = widget.routeDetails.first;
      final lat = firstLocation['Latitude'] as double?;
      final lng = firstLocation['Longitude'] as double?;

      if (lat != null && lng != null) {
        return CameraPosition(
          target: LatLng(lat, lng),
          zoom: 12.0,
        );
      }
    }

    // Default position if no route data available
    return CameraPosition(
      target: LatLng(10.8505, 76.2711),
      zoom: 12.0,
    );
  }

  Future<Uint8List> loadAssetImage(String assetPath) async {
    final ByteData byteData = await rootBundle.load(assetPath);
    return byteData.buffer.asUint8List();
  }
Future<List<LatLng>?> _fetchRouteGeometry(List<LatLng> waypoints) async {
  const apiKey = 'pk.eyJ1IjoibmFuZGFrcmlzaG5uIiwiYSI6ImNtMHpwZzkxcTA4eHoyaXF0cmU5Znh0bHYifQ.AxCRb6R-j52fETy4rq37cg'; // Replace with your Mapbox API token
  final coordinates = waypoints
      .map((latLng) => '${latLng.longitude},${latLng.latitude}')
      .join(';');
  final url =
      'https://api.mapbox.com/directions/v5/mapbox/driving/$coordinates?steps=true&geometries=geojson&access_token=$apiKey';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final route = data['routes'][0];
      final geometry = route['geometry']['coordinates'];
      return geometry
          .map<LatLng>((coord) => LatLng(coord[1], coord[0]))
          .toList();
    } else {
      print("Failed to fetch route data: ${response.statusCode}");
    }
  } catch (e) {
    print("Error fetching route data: $e");
  }
  return null;
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

        // Move the camera to the user's current location
        if (_controller != null && currentLocation != null) {
          _controller.animateCamera(CameraUpdate.newLatLng(currentLocation!));
          _addCurrentLocationMarker(); // Add marker for current location
        }
      });
    }
  }

  Future<void> _addCurrentLocationMarker() async {
    if (currentLocation != null) {
      await _controller.addSymbol(SymbolOptions(
        geometry: currentLocation!,
        iconImage: 'custom-marker', // Use the same custom marker image
        iconSize: 0.3,
        textField: 'You are here',
        textOffset: Offset(0, 1.5),
        textSize: 10.0,
        textColor: "#FF0000", // Red for current location text
      ));

      // Move the camera to current location
      _controller.animateCamera(CameraUpdate.newLatLng(currentLocation!));
    }
  }

Future<void> _showRouteMarkers() async {
  List<LatLng> routePoints = [];

  // Ensure current location is fetched before continuing
  if (currentLocation == null) {
    await _getCurrentLocation();
  }

  // Add the current location as the first point in the route
  if (currentLocation != null) {
    routePoints.add(currentLocation!);

    // Add symbol (marker) for current location
    await _controller.addSymbol(SymbolOptions(
      geometry: currentLocation!,
      iconImage: 'custom-marker',
      iconSize: 0.3,
      textField: 'You are here',
      textOffset: Offset(0, 1.5),
      textSize: 10.0,
      textColor: "#FF0000", // Red for current location text
    ));
  } else {
    print('Failed to get current location');
    return;
  }

  // Loop through the route details and add each place to routePoints and as a marker
  for (var route in widget.routeDetails) {
    if (route.containsKey('Latitude') && route.containsKey('Longitude')) {
      final lat = route['Latitude'] as double?;
      final lng = route['Longitude'] as double?;

      if (lat != null && lng != null) {
        final latLng = LatLng(lat, lng);
        routePoints.add(latLng);

        // Add symbol with the custom marker for shops
        await _controller.addSymbol(
          SymbolOptions(
            geometry: latLng,
            iconImage: 'custom-marker', // The custom marker image
            iconSize: 0.3,
            textField: route['ShopAdress'] ?? '', // The place name to display
            textOffset: Offset(0, 1.5),
            textSize: 8.0,
            textColor: "#000000", // Color of the text
          ),
        );
      }
    }
  }

  // Add route line connecting the points (starting from current location)
  if (routePoints.isNotEmpty) {
    final routeGeometry = await _fetchRouteGeometry(routePoints);
    if (routeGeometry != null) {
      await _controller.addLine(
        LineOptions(
          geometry: routeGeometry,
          lineColor: "#FF0000", // Red route line
          lineWidth: 3.0,
        ),
      );
    } else {
      print('Failed to fetch route geometry');
    }
  }
}


}
