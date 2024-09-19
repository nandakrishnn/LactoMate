import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lactomate/utils/colors.dart';
import 'package:lactomate/views/admin/drivers/driver_list.dart';
import 'package:lactomate/views/admin/home_card.dart';
import 'package:lactomate/views/admin/routes/routes_list.dart';
import 'package:lactomate/views/admin/shops/shop_adding.dart';
import 'package:lactomate/views/user_login.dart';
import 'package:lactomate/widgets/route_animations.dart';
import 'admin_chart.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.appcolorCream,
        automaticallyImplyLeading: false,
        title: Text(
          'Admin Home',
          style: TextStyle(color: AppColors.appcolorBlack, fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: AppColors.appcolorCream,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chart Section
            Container(
              margin: EdgeInsets.only(bottom: 20.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.appcolorWhite,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const DistributionChart(),
            ),
            

            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 1.2,
                ),
                children: [
                NavigationCard(
                  icon: Icons.car_crash,
                  label: 'Drivers',
                  onTap: () {
                    Navigator.of(context).push(createRoute(const DriverHome()));
                  },
                ),
                NavigationCard(
                  icon: Icons.store,
                  label: 'Shops',
                  onTap: () {
                    Navigator.of(context).push(createRoute(const ShopsList()));
                  },
                ),
                NavigationCard(
                  icon: Icons.route, 
                  label: 'Routes',
                  onTap: () {
                    Navigator.of(context).push(createRoute(const RoutesList()));
                  }),
                     NavigationCard(
                  icon: Icons.logout, 
                  
                  label: 'Logout',
                  onTap: () {
            showDialog(context: context, builder: (BuildContext context){
              return AlertDialog(title: const Text('Logout'),content: const Text('Are you sure to logout?'),
              actions: [
                TextButton(onPressed: (){
     Navigator.of(context).push(createRoute( WorkerLoginPage()));
                }, child: const Text('Yes')),
                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: const Text('No'))
              ],);
            });
                  })
                  
                  
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.appcolorBlack,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.appcolorCream, size: 32),
            SizedBox(height: 10.h),
            Text(
              label,
              style: TextStyle(
                color: AppColors.appcolorCream,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
