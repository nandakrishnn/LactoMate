import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lactomate/utils/constants.dart';
import 'package:lactomate/views/driver_view/map_driver_home.dart';

import 'package:lactomate/services/route_service.dart';
import 'package:lactomate/views/admin/routes/bloc_get_route_detail/get_route_detail_bloc.dart';
import 'package:lactomate/views/driver_view/top_progress.dart';

class DrivesWorkSpace extends StatelessWidget {
  final String workerId;
  DrivesWorkSpace({super.key, required this.workerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 450,
            child: BlocProvider(
              create: (context) => GetRouteDetailBloc(RouteService())
                ..add(FetchDriverData(workerId)),
              child: BlocConsumer<GetRouteDetailBloc, GetRouteDetailState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetRouteDetailLoaded) {
                    // Assuming state.data is a List<dynamic> from Firestore
                    final List<dynamic> dataList = state.data as List<dynamic>;

                    if (dataList.isNotEmpty) {
                      // print("Data List Received: ${dataList.length} items");

                      for (var route in dataList) {
                        if (route is DocumentSnapshot) {
                          final Map<String, dynamic>? routeData =
                              route.data() as Map<String, dynamic>?;

                          if (routeData != null) {
                            print("Route Data: $routeData");
                          } else {
                            print("No data in DocumentSnapshot.");
                          }
                        } else {
                          print("Unexpected data format: $route");
                        }
                      }
                    } else {
                      print("No data received or list is empty.");
                    }

                    List<Map<String, dynamic>> routeDetails = [];

// Extract route details
                    for (var item in dataList) {
                      if (item is DocumentSnapshot) {
                        final Map<String, dynamic>? routeData =
                            item.data() as Map<String, dynamic>?;

                        if (routeData != null &&
                            routeData.containsKey('RouteDetails')) {
                          print("Extracting RouteDetails from: $routeData");

                          // Safely add RouteDetails to routeDetails list
                          final List<dynamic> routeDetailsList =
                              routeData['RouteDetails'] as List<dynamic>;
                          routeDetails.addAll(List<Map<String, dynamic>>.from(
                              routeDetailsList));
                        }
                      }
                    }

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
          CustomStepper(),
          Text('Mark Compleated shops')
        ],
      ),
    );
  }
}
