import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lactomate/functions/function.dart';
import 'package:lactomate/utils/constants.dart';
import 'package:lactomate/views/admin/shops/bloc_add_shop/shop_details_addition_bloc.dart';
import 'package:lactomate/views/admin/shops/edit_map_screen.dart';
import 'package:lactomate/views/admin/shops/map_screen.dart';
import 'package:lactomate/widgets/custom_snack.dart';
import 'package:lactomate/widgets/login_button.dart';
import 'package:lactomate/widgets/textformfeild2.dart';

class EditShopDetails extends StatelessWidget {
  final data;
  const EditShopDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    TextEditingController payLoadController =
        TextEditingController(text: data['PayLoad']);
    TextEditingController nameController =
        TextEditingController(text: data['ShopName']);
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    String? profileimg;
    Map<String, dynamic>? selectedLocation;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Shop Details'),
        centerTitle: true,
      ),
      body: BlocConsumer<ShopDetailsAdditionBloc, ShopDetailsAdditionState>(
        listener: (context, state) {
          if (state.status == ShopDetailsStatus.sucess) {
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
                        nameController.clear();
                        payLoadController.clear();
                      
                  state.status=ShopDetailsStatus.inital;
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.network(
                  'https://images.pexels.com/photos/93398/pexels-photo-93398.jpeg',
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
                child: Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        AppConstants.kheight60,
                        AppConstants.kheight20,
                        GestureDetector(
                          onTap: () async {
                            final img =
                                await ProjectFunctionalites().imagePickercir();

                            if (img != null) {
                              context
                                  .read<ShopDetailsAdditionBloc>()
                                  .add(ShopImageChnages(img.path));
                              profileimg = img.path;
                            }
                          },
                          child: CircleAvatar(
                            radius: 90,
                            backgroundColor:
                                const Color.fromARGB(255, 216, 214, 214),
                            foregroundColor:
                                const Color.fromARGB(255, 132, 132, 132),
                            backgroundImage: profileimg != null
                                ? FileImage(File(state.imgurl!))
                                : NetworkImage(data['ShopImage']),
                          ),
                        ),
                        AppConstants.kheight20,
                        CustomTextFeild2(
                          onChanged: (p0) => context
                              .read<ShopDetailsAdditionBloc>()
                              .add(ShopNameChnages(p0)),
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
                          onChanged: (p0) => context
                              .read<ShopDetailsAdditionBloc>()
                              .add(ShopPayLoadChanges(p0)),
                          controller: payLoadController,
                          heading: 'PayLoad (Kg)',
                          hinttext: '10 kg',
                          validator: (p0) {
                            if (p0!.isEmpty || p0 == 0) {
                              return 'The value should be more than 0';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          height: 500,
                          child: EditScreenMap(
                            location: data['ShopAdress'],
                            onLocationSelected: (location) {
                              selectedLocation = location;
                            },
                          ),
                        ),
                        AppConstants.kheight20,
                        LoginContainer(
                          content: 'Save Details',
                       
                          ontap: () async {
                            // print(selectedLocation!['latitude']);

                            String? firestoreUpdatedImage;

                            if (profileimg != null) {
                              firestoreUpdatedImage =
                                  await ProjectFunctionalites()
                                      .uploadImageToFirebase(File(profileimg!));
                                      print(firestoreUpdatedImage);
                            } else {
                              firestoreUpdatedImage = data['ShopImage'];
                            }

                            if (selectedLocation != null) {
                              print(selectedLocation);
                              BlocProvider.of<ShopDetailsAdditionBloc>(context)
                                  .add(UpdateShopFormSubmit(
                                name: nameController.text,
                                adress: selectedLocation!['placeName'],
                                image: firestoreUpdatedImage!,
                                latitude: selectedLocation!['latitude'],
                                longitude: selectedLocation!['longitude'],
                                id: data['ShopId'],
                                payload: payLoadController.text,
                              ));

                              state.status = ShopDetailsStatus.inital;

                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
