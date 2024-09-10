import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lactomate/functions/function.dart';
import 'package:lactomate/utils/colors.dart';
import 'package:lactomate/utils/constants.dart';
import 'package:lactomate/utils/validators.dart';
import 'package:lactomate/widgets/login_button.dart';
import 'package:lactomate/widgets/textformfeild2.dart';

class AddDriver extends StatelessWidget {
  const AddDriver({super.key});


  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController dobController = TextEditingController();
    TextEditingController idProofController = TextEditingController();
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    String? profileimg;
    String? proofimage;

    return Scaffold(
  
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'ADD DRIVER',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: Stack(
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
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            AppConstants.kheight60,
                            AppConstants.kheight20,
                            GestureDetector(
                              onTap: () async {
                                final img = await ProjectFunctionalites()
                                    .imagePickercir();

                                if (img != null) {
                             
                                }
                              },
                              child: CircleAvatar(
                                  radius: 90,
                                  backgroundColor:
                                      const Color.fromARGB(255, 216, 214, 214),
                                  foregroundColor:
                                      const Color.fromARGB(255, 132, 132, 132),
                                  backgroundImage: profileimg != null
                                      ? FileImage(File(profileimg!))
                                      : null,
                                  child: profileimg == null
                                      ? const Icon(Icons.camera)
                                      : null),
                            ),
                            AppConstants.kheight20,
                            CustomTextFeild2(
                           
                              controller: nameController,
                              heading: 'Full Name',
                              hinttext: 'Full Name',
                              validator: (value) =>Validators.validateName(value)
                            ),
                            AppConstants.kheight20,
                            CustomTextFeild2(
                            
                              controller: phoneController,
                              heading: 'Phone Number',
                              hinttext: 'Phone Number',
                              keybordtype: TextInputType.phone,
                              validator: (value) =>Validators.validatePhoneNumber(value),
                            ),
                            AppConstants.kheight20,
                            CustomTextFeild2(
                            
                              controller: emailController,
                              heading: 'Email Address',
                              hinttext: 'Email Address',
                              keybordtype: TextInputType.emailAddress,
                              validator: (value) =>Validators.validateEmail(value)
                            ),
                            AppConstants.kheight20,
                            CustomTextFeild2(
                            readOnly: true,
                                  //  onChanged: (value) => context.read<JobApplicationEmployeBloc>().add(UserWorkType(workController.text)),
                              sufixbutton: const Icon(
                                Icons.calendar_month,
                                size: 20,
                              ),
                              tap: (){},
                              controller: dobController,
                              heading: 'Date of Birth',
                              hinttext: '12-Sept-2002',
                              
                              validator: (p0) {
                                
                                if(p0==null||p0.isEmpty){
                                  return 'Selec DOB';
                                }return null;
                              },
                              
                         
                            ),
                            // AppConstants.kheight20,
                            // CustomTextFeild2(
                         
                            //   controller: yearsController,
                            //   heading: 'Years of experience',
                            //   hinttext: 'Years of experience',
                            //   keybordtype: TextInputType.number,
                            //   validator:(value)=>Validators.validateYearsOfExperience(value)
                            // ),
                            AppConstants.kheight20,
                            CustomTextFeild2(
                              readOnly: true,
                              controller: idProofController,
                              sufixbutton: const Icon(Icons.attachment),
                              tap: () async {
                                final proofUrl = await ProjectFunctionalites()
                                    .imagePickercir();
                                if (proofUrl != null) {
                                  final File idProofFile = File(proofUrl.path);
                                  proofimage = proofUrl.path;

                                  idProofController.text = idProofFile.path;
                                }
                              },
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
                            Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                                child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .9,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .4,
                                                    child: proofimage != null
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            child: DecoratedBox(
                                                              decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: FileImage(File(
                                                                        proofimage!,
                                                                      )),
                                                                      fit: BoxFit.cover)),
                                                            ),
                                                          )
                                                        : const Center(
                                                            child: Text(
                                                                'Select DL to preview here'),
                                                          )));
                                          });
                                    },
                                    child:  Text(
                                      'View proof',
                                      style: TextStyle(
                                          color: AppColors.appcolorBlack),
                                    ))),
                            AppConstants.kheight30,
                            GestureDetector(
                                onTap: () async {
                                
                                },
                                child: LoginContainer(content: 'Submit')),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

  
    );
  }
}