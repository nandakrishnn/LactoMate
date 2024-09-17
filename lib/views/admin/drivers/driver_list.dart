import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lactomate/services/driver_service.dart';
import 'package:lactomate/utils/colors.dart';
import 'package:lactomate/utils/constants.dart';
import 'package:lactomate/views/admin/drivers/add_driver.dart';
import 'package:lactomate/widgets/route_animations.dart';
import 'package:lactomate/widgets/three_dots.dart';

import 'get_diriver_home/get_cart_details_user_bloc.dart';

class DriverHome extends StatelessWidget {
  const DriverHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Driver List'),
          backgroundColor: AppColors.appcolorCream,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: AppColors.appcolorCream,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.appcolorBlack,
          onPressed: () {
            Navigator.of(context).push(createRoute(AddDriver()));
          },
          child: Text(
            '+',
            style: TextStyle(color: AppColors.appcolorCream),
          ),
        ),
        body: BlocProvider(
          create: (context) =>
              GetWorkerDetailsUserBloc(DriverService())..add(FetchWorkerData()),
          child: BlocConsumer<GetWorkerDetailsUserBloc, GetDriverDetailsState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetWorkerLoaded) {
                final data = state.data;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return DriverHomeList(
                    data: data[index],
                        name: data[index]['DriverName'],
                        img: data[index]['DriverImg'],
                        email: data[index]['DriverEmail'],
                      );
                    });
              }
              return Container();
            },
          ),
        ));
  }
}

class DriverHomeList extends StatelessWidget {
  String name;
final data;
  String img;
  String email;
  DriverHomeList({
    required this.data,
    required this.email,
    required this.name,
    required this.img,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Shadow color
              spreadRadius: 2, // How much the shadow spreads
              blurRadius: 5, // Softness of the shadow
              offset: Offset(0, 3), // Position of the shadow
            ),
          ],
          color: AppColors.appcolorBlack,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              AppConstants.kwidth10,
              CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(img),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              color: AppColors.appcolorCream,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        DropDownMenuSubCatgeory(
             data: data,
                          color: AppColors.appcolorCream,
                          icon: Icon(
                            Icons.more_vert,
                            color: AppColors.appcolorCream,
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        email,
                        style: TextStyle(
                            color: AppColors.appcolorCream,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
