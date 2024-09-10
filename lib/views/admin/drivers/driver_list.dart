import 'package:flutter/material.dart';
import 'package:lactomate/utils/colors.dart';
import 'package:lactomate/views/admin/drivers/add_driver.dart';
import 'package:lactomate/widgets/route_animations.dart';

class DriverHome extends StatelessWidget {
  const DriverHome({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          backgroundColor:AppColors.appcolorCream,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.appcolorBlack,
        onPressed: (){
      Navigator.of(context).push(createRoute(AddDriver()));
      },child: Text('+',style: TextStyle(color: AppColors.appcolorCream),),),
    );
  }
}