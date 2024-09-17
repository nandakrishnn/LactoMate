import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lactomate/functions/function.dart';
import 'package:lactomate/services/shop_service.dart';
import 'package:lactomate/utils/colors.dart';
import 'package:lactomate/utils/constants.dart';
import 'package:lactomate/utils/validators.dart';
import 'package:lactomate/views/admin/shops/bloc_get_shop/get_shop_details_bloc.dart';
import 'package:lactomate/widgets/login_button.dart';
import 'package:lactomate/widgets/textformfeild2.dart';

class AddRouteDetails extends StatelessWidget {
  const AddRouteDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController dobController = TextEditingController();
    TextEditingController idProofController = TextEditingController();
    TextEditingController driverIdController = TextEditingController();
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    String? profileimg;
    String? proofimage;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Add Route',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                'assets/pexels-photo-93398 (1).jpeg',
                fit: BoxFit.cover,
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      AppConstants.kheight60,
                      AppConstants.kheight20,
                      AppConstants.kheight20,
                      CustomTextFeild2(
                          controller: nameController,
                          heading: 'Route Name',
                          hinttext: 'Route Name',
                          validator: (value) => Validators.validateName(value)),
                      AppConstants.kheight20,
                      CustomTextFeild2(
                        controller: phoneController,
                        heading: 'Add Shops',
                        hinttext: 'Select Shops to add',
                        keybordtype: TextInputType.phone,
                        validator: (value) =>
                            Validators.validatePhoneNumber(value),
                        sufixbutton: const Icon(Icons.arrow_drop_down),
                        tap: () {
                          showModalBottomSheet(
                            showDragHandle: true,

                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            backgroundColor: Colors
                                .grey[900], // Customize the background color
                            builder: (BuildContext context) {
                              return BlocProvider(
                                create: (context) => GetShopDetailsBloc(ShopService())..add(FetchShopDetails()),
                                child: BlocBuilder<GetShopDetailsBloc,
                                    GetShopDetailsState>(
                                  builder: (context, state) {
                                    if (state is GetShopDetailsLoaded) {
                                      final shopList = state
                                          .data; // Assuming shopList is from the state

                                      return Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: shopList
                                              .length, // Number of shops
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[850],
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 5,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  // Circle avatar with shop image
                                                  CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      shopList[index]
                                                              ['ShopImage'] ??
                                                          'https://via.placeholder.com/150', // Use a placeholder if no image
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  // Title and subtitle
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          shopList[index][
                                                                  'ShopName'] ??
                                                              'Shop Name',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 4),
                                                        Text(
                                                          shopList[index][
                                                                  'ShopAdress'] ??
                                                              'Shop Details',
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.white70,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                      AppConstants.kheight20,
                      CustomTextFeild2(
                        readOnly: true,
                        controller: idProofController,
                        sufixbutton: const Icon(Icons.attachment),
                        tap: () async {},
                        hinttext: 'Driving Licence',
                        heading: 'Driving Licence',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please add your DL';
                          }
                          return null;
                        },
                      ),
                      AppConstants.kheight10,
                      GestureDetector(
                          onTap: () async {},
                          child: LoginContainer(content: 'Submit')),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
