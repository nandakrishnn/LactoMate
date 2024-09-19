import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lactomate/utils/colors.dart';
import 'package:lactomate/views/driver_view/home_driver.dart';
import 'package:lactomate/views/driver_view/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  String? workerId;
  final ValueNotifier<bool> bottomNavBarVisible = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _initializeWorkerId();
  }

  Future<void> _initializeWorkerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    workerId = prefs.getString('WorkerId');
    setState(() {}); // Rebuild the widget to reflect the updated workerId
  }

  List<Widget> get screens {
    // Ensure workerId is not null before creating the list
    return [
      if (workerId != null) DrivesWorkSpace(workerId: workerId!) else Container(),
      ProfileDriver()
  
    ];
  }

  void setPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.reverse) {
            bottomNavBarVisible.value = false;
          } else if (notification.direction == ScrollDirection.forward) {
            bottomNavBarVisible.value = true;
          }
          return true;
        },
        // Use IndexedStack to keep the state of each screen
        child: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<bool>(
        valueListenable: bottomNavBarVisible,
        builder: (context, isVisible, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isVisible ? kBottomNavigationBarHeight + 15 : 0,
            child: isVisible ? child : const SizedBox.shrink(),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 90, right: 90),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(149, 78, 73, 73),
                  offset: Offset(0, 0),
                  spreadRadius: 2,
                  blurRadius: 5,
                )
              ],
              color: AppColors.appcolorBlack,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: GNav(
                haptic: true,
                color: AppColors.appcolorCream,
                activeColor: AppColors.appcolorBlack,
                gap: 8,
                onTabChange: setPage,
                padding: const EdgeInsets.all(16),
                textStyle:  TextStyle(color: AppColors.appcolorBlack,fontSize: 18),
                tabBackgroundColor: AppColors.appcolorCream,
                selectedIndex: currentIndex, // Ensure correct tab is highlighted
                tabs:  [
                  GButton(
               
                    icon: Icons.design_services,
                    text: 'Service',
                  ),
                  GButton(
                    icon: Icons.person_2_sharp,
                    text: 'Profile',
                  ),
                  // Add other tabs as needed
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
