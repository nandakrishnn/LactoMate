import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lactomate/functions/function.dart';
import 'package:lactomate/utils/colors.dart';
import 'package:lactomate/utils/constants.dart';
import 'package:lactomate/views/admin/drivers/add_drivers_bloc/add_driver_details_bloc.dart';
import 'package:lactomate/views/admin/shops/map_screen.dart';
import 'package:lactomate/widgets/textformfeild2.dart';

class AddShopDetails extends StatelessWidget {
  const AddShopDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController payLoadController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    String? profileimg;

    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Details'),
        backgroundColor: AppColors.appcolorCream,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
            
              children: [
                AppConstants.kheight20,
                Text(
                  'Choose the Image of the Shop',
                  style: TextStyle(
                    color: AppColors.appcolorBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                AppConstants.kheight20,
                GestureDetector(
                  onTap: () async {
                    final img = await ProjectFunctionalites().imagePickercir();

                    if (img != null) {
                      context
                          .read<AddDriverDetailsBloc>()
                          .add(DriverImageChnages(img.path));
                      profileimg = img.path;
                    }
                  },
                  child: CircleAvatar(
                    radius: 90,
                    backgroundColor: const Color.fromARGB(255, 216, 214, 214),
                    foregroundColor: const Color.fromARGB(255, 132, 132, 132),
                    backgroundImage: profileimg != null
                        ? FileImage(File(profileimg!))
                        : null,
                    child: profileimg == null
                        ? const Icon(Icons.camera)
                        : null,
                  ),
                ),
                AppConstants.kheight20,
                CustomTextFeild2(
                  controller: nameController,
                  heading: 'Name of the shop',
                  hinttext: 'Lulu Hypermart',
                  validator: (p0) {
                    if (p0!.isEmpty || p0 == 0) {
                      return 'The value should be more than 0';
                    }
                    return null;
                  },
                ),
                AppConstants.kheight20,
                CustomTextFeild2(
                  controller: payLoadController,
                  heading: 'PayLoad (Kg)',
                  hinttext: '10 kg,20 kg',
                  validator: (p0) {
                    if (p0!.isEmpty || p0 == 0) {
                      return 'The value should be more than 0';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Container(
                  height: 500, // Adjust the height for the map view
                  child: SearchMapScreen(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
