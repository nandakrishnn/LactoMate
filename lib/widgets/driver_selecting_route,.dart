import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lactomate/services/driver_service.dart';
import 'package:lactomate/views/admin/drivers/get_diriver_home/get_cart_details_user_bloc.dart';
import 'package:lactomate/views/admin/routes/bloc_shops_in_route/route_shops_list_addition_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouteDriverSelectingWidget extends StatefulWidget {
  const RouteDriverSelectingWidget({super.key});

  @override
  _RouteDriverSelectingWidgetState createState() =>
      _RouteDriverSelectingWidgetState();
}

class _RouteDriverSelectingWidgetState
    extends State<RouteDriverSelectingWidget> {
  bool _isDropdownOpen = false;
  String? selectedDriver;
  Map<String, dynamic>? selectedDriverDetails;
  TextEditingController driverController = TextEditingController();

  // Define the height of each item in the dropdown list
  final double _itemHeight = 80.0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetWorkerDetailsUserBloc(DriverService())..add(FetchWorkerData()),
      child: BlocConsumer<GetWorkerDetailsUserBloc, GetDriverDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetWorkerLoaded) {
            // Extract the data from Firestore snapshots
            final driverList = state.data
                .map((doc) => doc.data() as Map<String, dynamic>)
                .toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose Driver',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // TextFormField with dropdown functionality
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isDropdownOpen = !_isDropdownOpen;
                    });
                  },
                  child: TextFormField(
                    controller: driverController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Select Driver',
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    onTap: () {
                      setState(() {
                        _isDropdownOpen = !_isDropdownOpen;
                      });
                    },
                  ),
                ),

                // Animated container that expands and collapses
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: _isDropdownOpen
                      ? (driverList.length * _itemHeight)
                          .clamp(0, 300) // Maximum height of 300
                      : 0,
                  curve: Curves.easeInOut,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: driverList.length,
                    itemBuilder: (context, index) {
                      final driver = driverList[index];

                      return GestureDetector(
                        onTap: () async {
                          setState(() {
                            selectedDriver = driver['DriverCode'];
                            selectedDriverDetails = driver;
                            driverController.text = driver[
                                'DriverName']; // Set the selected driver in the TextFormField
                            _isDropdownOpen =
                                false; // Close the dropdown after selection
                          });

                          context
                              .read<RouteShopsListAdditionBloc>()
                              .add(DriverIdChanges(driver['DriverId']));
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString(
                              'ChoosenDriverRoute', driver['DriverId']);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16), // Add more padding
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[100],
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage(
                                  driver['DriverImg'] ??
                                      'https://via.placeholder.com/150',
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  driver['DriverName'] ?? 'Driver Name',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
