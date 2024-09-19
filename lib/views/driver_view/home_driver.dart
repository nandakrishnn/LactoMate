import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lactomate/utils/colors.dart';
import 'package:location/location.dart'; // Import for location
import 'package:lactomate/utils/constants.dart';
import 'package:lactomate/views/driver_view/map_driver_home.dart';
import 'package:lactomate/services/route_service.dart';
import 'package:lactomate/views/admin/routes/bloc_get_route_detail/get_route_detail_bloc.dart';
import 'package:lactomate/views/driver_view/shops_list.dart';

class DrivesWorkSpace extends StatefulWidget {
  final String workerId;

  DrivesWorkSpace({super.key, required this.workerId});

  @override
  _DrivesWorkSpaceState createState() => _DrivesWorkSpaceState();
}

class _DrivesWorkSpaceState extends State<DrivesWorkSpace> {
  LocationData? _currentLocation;
  bool _loading = true;
  final Location _location = Location();
  String? id;
  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    final bool _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      final bool _enabled = await _location.requestService();
      if (!_enabled) {
        // Handle location service disabled
        setState(() {
          _loading = false;
        });
        return;
      }
    }

    final PermissionStatus _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      final PermissionStatus _permissionRequested =
          await _location.requestPermission();
      if (_permissionRequested != PermissionStatus.granted) {
        // Handle permission denied
        setState(() {
          _loading = false;
        });
        return;
      }
    }

    try {
      final LocationData location = await _location.getLocation();
      setState(() {
        _currentLocation = location;
        _loading = false;
      });
    } catch (e) {
      // Handle location fetching error
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        body: Center(child: CupertinoActivityIndicator()),
      );
    }

    if (_currentLocation == null) {
      return Scaffold(
        body: Center(child: Text('Failed to get location')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.appcolorCream,
      body: Column(
        children: [
          SizedBox(
            height: 500,
            child: BlocProvider(
              create: (context) => GetRouteDetailBloc(RouteService())
                ..add(FetchDriverData(widget.workerId)),
              child: BlocConsumer<GetRouteDetailBloc, GetRouteDetailState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetRouteDetailLoaded) {
                    final List<dynamic> dataList = state.data as List<dynamic>;

                    List<Map<String, dynamic>> routeDetails = [];

                    for (var item in dataList) {
                      if (item is DocumentSnapshot) {
                        final Map<String, dynamic>? routeData =
                            item.data() as Map<String, dynamic>?;

                        if (routeData != null &&
                            routeData.containsKey('RouteDetails')) {
                          final List<dynamic> routeDetailsList =
                              routeData['RouteDetails'] as List<dynamic>;
                          routeDetails.addAll(List<Map<String, dynamic>>.from(
                              routeDetailsList));
                        }
                      }
                    }

                    // Sort routeDetails based on distance from currentLocation
                    routeDetails.sort((a, b) {
                      final aLat = a['Latitude'] as double;
                      final aLng = a['Longitude'] as double;
                      final bLat = b['Latitude'] as double;
                      final bLng = b['Longitude'] as double;

                      final distanceA = _calculateDistance(
                        _currentLocation!.latitude!,
                        _currentLocation!.longitude!,
                        aLat,
                        aLng,
                      );
                      final distanceB = _calculateDistance(
                        _currentLocation!.latitude!,
                        _currentLocation!.longitude!,
                        bLat,
                        bLng,
                      );

                      return distanceA.compareTo(distanceB);
                    });

                    return MapboxMapWidget(routeDetails: routeDetails);
                  } else if (state is GetRouteDetailFailure) {
                    return Center(child: Text('Error: ${state.errorMsg}'));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
          AppConstants.kheight10,
          Text(
            'Shops to cover',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: BlocProvider(
              create: (context) => GetRouteDetailBloc(RouteService())
                ..add(FetchDriverData(widget.workerId)),
              child: BlocConsumer<GetRouteDetailBloc, GetRouteDetailState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetRouteDetailLoaded) {
                  
                    final List<dynamic> dataList = state.data as List<dynamic>;

                    List<Map<String, dynamic>> routeDetails = [];

                    for (var item in dataList) {
                      if (item is DocumentSnapshot) {
                        final Map<String, dynamic>? routeData =
                            item.data() as Map<String, dynamic>?;
                        id = routeData!['RouteId'];

                        if (routeData != null &&
                            routeData.containsKey('RouteDetails')) {
                          final List<dynamic> routeDetailsList =
                              routeData['RouteDetails'] as List<dynamic>;
                          routeDetails.addAll(List<Map<String, dynamic>>.from(
                              routeDetailsList));
                        }
                      }
                    }

                    // Sort routeDetails based on distance from currentLocation
                    routeDetails.sort((a, b) {
                      final aLat = a['Latitude'] as double;
                      final aLng = a['Longitude'] as double;
                      final bLat = b['Latitude'] as double;
                      final bLng = b['Longitude'] as double;

                      final distanceA = _calculateDistance(
                        _currentLocation!.latitude!,
                        _currentLocation!.longitude!,
                        aLat,
                        aLng,
                      );
                      final distanceB = _calculateDistance(
                        _currentLocation!.latitude!,
                        _currentLocation!.longitude!,
                        bLat,
                        bLng,
                      );

                      return distanceA.compareTo(distanceB);
                    });

                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: routeDetails.length,
                      itemBuilder: (context, index) {
                        print(id);
                        return RouteItemContainer(
                          routeDetail: routeDetails[index],
                          id: id,
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateDistance(
      double startLat, double startLng, double endLat, double endLng) {
    // Calculate the distance between two geographical points
    const double pi = 3.141592653589793;
    const double earthRadius = 6371.0; // Radius of Earth in kilometers

    double dLat = (endLat - startLat) * pi / 180.0;
    double dLng = (endLng - startLng) * pi / 180.0;

    double a = (sin(dLat / 2) * sin(dLat / 2)) +
        (cos(startLat * pi / 180.0) *
            cos(endLat * pi / 180.0) *
            sin(dLng / 2) *
            sin(dLng / 2));

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }
}
