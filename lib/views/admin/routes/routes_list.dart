import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lactomate/services/route_service.dart';
import 'package:lactomate/services/driver_service.dart';
import 'package:lactomate/utils/colors.dart';
import 'package:lactomate/views/admin/routes/add_route_details.dart';
import 'package:lactomate/views/admin/routes/bloc_get_route_detail/get_route_detail_bloc.dart';
import 'package:lactomate/widgets/route_animations.dart';

class RoutesList extends StatelessWidget {
  const RoutesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routes List'),
        backgroundColor: AppColors.appcolorCream,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.appcolorCream,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(createRoute(const AddRouteDetails()));
        },
        backgroundColor: AppColors.appcolorBlack,
        child: const Icon(Icons.add),
      ),
      body: BlocProvider(
        create: (context) => GetRouteDetailBloc(RouteService())..add(FetchRouteDetails()),
        child: BlocConsumer<GetRouteDetailBloc, GetRouteDetailState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetRouteDetailLoaded) {
              final data = state.data;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final routeData = data[index];
                  return FutureBuilder<Map<String, dynamic>>(
                    future: DriverService().getDriverDetail(routeData['AssignedDriver']),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Container(
                          height: 80.h,
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.appcolorBlack,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Center(
                              child: Text('Error fetching driver details',
                                  style: TextStyle(color: Colors.red))),
                        );
                      } else if (!snapshot.hasData) {
                        return Container(
                          height: 80.h,
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.appcolorBlack,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child:const Center(
                              child: Text('No driver details available',
                                  style: TextStyle(color: Colors.grey, fontSize: 6))),
                        );
                      } else {
                        final driverDetails = snapshot.data!;
                        final driverName = driverDetails['DriverName'] ?? 'Unknown Driver';

                        return Container(
                          height: 86.h,
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: AppColors.appcolorBlack,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.route,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      routeData['RouteName'] ?? 'Unnamed Route',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp, // Decreased heading size
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: Colors.white70,
                                    size: 24,
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Text(
                                      'Driver: $driverName',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14.sp, // Adjusted driver name size
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
