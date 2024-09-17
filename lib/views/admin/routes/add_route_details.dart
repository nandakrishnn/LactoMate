import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lactomate/services/shop_service.dart';

import 'package:lactomate/utils/constants.dart';
import 'package:lactomate/utils/validators.dart';
import 'package:lactomate/views/admin/routes/bloc_shops_in_route/route_shops_list_addition_bloc.dart';
import 'package:lactomate/views/admin/shops/bloc_get_shop/get_shop_details_bloc.dart';
import 'package:lactomate/widgets/custom_snack.dart';
import 'package:lactomate/widgets/login_button.dart';
import 'package:lactomate/widgets/textformfeild2.dart';

class AddRouteDetails extends StatelessWidget {
  const AddRouteDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController shopsController = TextEditingController();
    List<Map<String, dynamic>> selectedShops = [];
    GlobalKey<FormState> formkey = GlobalKey<FormState>();

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
                  child: BlocConsumer<RouteShopsListAdditionBloc,
                      RouteShopsListAdditionState>(
                    listener: (context, state) {
                      if (state.status == RouteDetailsUploadStatus.sucess) {
                        ScaffoldMessenger.of(context).showSnackBar(customSnack(
                            'Updating Details',
                            'Details are being added',
                            const Icon(
                              Icons.done,
                              color: Colors.green,
                              size: 28,
                            ),
                            Colors.green));
                        nameController.clear();
                        shopsController.clear();
                        selectedShops.clear();
                        state.status = RouteDetailsUploadStatus.inital;
                        // Reset the BLoC state

                        // Pop the screen
                        Navigator.of(context).pop();
                      }
                      // if (state.status == RouteDetailsUploadStatus.pending) {
                      //   Center(
                      //     child: CircularProgressIndicator(),
                      //   );
                      // }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          AppConstants.kheight60,
                          AppConstants.kheight20,
                          AppConstants.kheight20,
                          CustomTextFeild2(
                              onChanged: (p0) => context
                                  .read<RouteShopsListAdditionBloc>()
                                  .add(RouteNameChanges(p0)),
                              controller: nameController,
                              heading: 'Route Name',
                              hinttext: 'Route Name',
                              validator: (value) =>
                                  Validators.validateName(value)),
                          AppConstants.kheight20,

                          CustomTextFeild2(
                            controller: shopsController,
                            heading: 'Add Shops',
                            hinttext: 'Select Shops to add',
                            readOnly: true,
                            validator: (value) =>
                                Validators.validateName(value),
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
                                backgroundColor: Colors.grey[900],
                                builder: (BuildContext context) {
                                  return BlocProvider(
                                    create: (context) =>
                                        GetShopDetailsBloc(ShopService())
                                          ..add(FetchShopDetails()),
                                    child: BlocBuilder<GetShopDetailsBloc,
                                        GetShopDetailsState>(
                                      builder: (context, state) {
                                        if (state is GetShopDetailsLoaded) {
                                          final shopList = state.data
                                              .map((doc) => doc.data()
                                                  as Map<String, dynamic>)
                                              .toList();
                                          return Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: shopList.length,
                                              itemBuilder: (context, index) {
                                                final shopName =
                                                    shopList[index]['ShopName'];

                                                return GestureDetector(
                                                  onTap: () {
                                                    final shop = shopList[
                                                        index]; // Capture the entire shop details

                                                    if (!selectedShops
                                                        .contains(shop)) {
                                                      selectedShops.add(shop as Map<
                                                          String,
                                                          dynamic>); // Add the selected shop details
                                                    } else {
                                                      selectedShops.remove(
                                                          shop); // Remove the shop if deselected
                                                    }

                                                    // Update the TextFormField with the selected shop names
                                                    shopsController.text =
                                                        selectedShops
                                                            .map((shop) => shop[
                                                                'ShopName'])
                                                            .join(', ');
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(vertical: 8),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[850],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Colors.black26,
                                                          blurRadius: 5,
                                                          offset: const Offset(
                                                              0, 2),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 30,
                                                          backgroundImage:
                                                              NetworkImage(
                                                            shopList[index][
                                                                    'ShopImage'] ??
                                                                'https://via.placeholder.com/150',
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 12),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                shopName ??
                                                                    'Shop Name',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
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
                                                                  color: Colors
                                                                      .white70,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        } else {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),

                          AppConstants.kheight20,
                          // CustomTextFeild2(
                          //   readOnly: true,
                          //   controller: idProofController,
                          //   sufixbutton: const Icon(Icons.attachment),
                          //   tap: () async {},
                          //   hinttext: 'Driving Licence',
                          //   heading: 'Driving Licence',
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Please add your DL';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          AppConstants.kheight10,
                          LoginContainer(
                            content: 'Submit',
                            ontap: () async {
                              print('button');
                              if (formkey.currentState!.validate()) {
                                context
                                    .read<RouteShopsListAdditionBloc>()
                                    .add(ShopDetailsChanges(selectedShops));

                                context
                                    .read<RouteShopsListAdditionBloc>()
                                    .add(ShopFormSubmit());
                              }
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
