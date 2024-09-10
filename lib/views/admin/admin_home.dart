
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lactomate/utils/colors.dart';
import 'package:lactomate/utils/constants.dart';
import 'package:lactomate/views/admin/drivers/driver_list.dart';
import 'package:lactomate/widgets/route_animations.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Admin Home'),
      ),
      backgroundColor: AppColors.appcolorCream,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(createRoute(DriverHome()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                        color: AppColors.appcolorBlack,
                    ),
                    height: 140.h,
                    width: 167.w,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                          Icon(Icons.car_crash,color: AppColors.appcolorCream,),
                          AppConstants.kwidth10,
                          Text('Drivers',style: TextStyle(
                            color: AppColors.appcolorCream,
                            fontSize: 18
                          ),)
                          ],
                        ),
                      ),
                    ),
                  
                  ),
                ),
                AppConstants.kwidth10,
                      Container(
                  height: 140.h,
                  width: 167.w,
                  color: AppColors.appcolorBlack,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}