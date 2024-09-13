import 'package:flutter/material.dart';
import 'package:lactomate/utils/colors.dart';
import 'package:lactomate/views/admin/shops/add_shop_details.dart';
import 'package:lactomate/widgets/route_animations.dart';

class ShopsList extends StatelessWidget {
  const ShopsList({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(createRoute(AddShopDetails()));
      },child: Text('+',style: TextStyle(color: AppColors.appcolorCream),),backgroundColor: AppColors.appcolorBlack,),
      backgroundColor: AppColors.appcolorCream,
    );
  }
}