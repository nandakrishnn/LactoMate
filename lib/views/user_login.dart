// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lactomate/services/driver_service.dart';
import 'package:lactomate/utils/colors.dart';
import 'package:lactomate/utils/constants.dart';
import 'package:lactomate/utils/validators.dart';
import 'package:lactomate/views/admin/admin_home.dart';
import 'package:lactomate/views/driver_view/bottom_nav_worker.dart';
import 'package:lactomate/views/driver_view/home_driver.dart';
import 'package:lactomate/widgets/custom_snack.dart';
import 'package:lactomate/widgets/login_button.dart';
import 'package:lactomate/widgets/route_animations.dart';
import 'package:lactomate/widgets/textformfeild.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerLoginPage extends StatelessWidget {
  WorkerLoginPage({super.key});
  final String adminEmail = 'unandakrishnan@gmail.com';
  final String adminPass = '123456';
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appcolorCream,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 230,
                  child: Image.asset('assets/Screenshot_2024-09-19_175351-removebg-preview.png',fit: BoxFit.cover,),),
             
                const Text(
                  'Welcome back! Glad to see you, Again!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                CustomTextFeild(
                  obscure: false,
                  hinttext: 'Enter your Email',
                  controller: emailController,
                  validator: (value) => Validators.validateEmail(
                      value), // Add validator to FormField
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .04,
                ),
                CustomTextFeild(
                  obscure: true,
                  hinttext: 'Enter your Password',
                  controller: passController,
                
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your password';
                    }
                    if (value.length < 4) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                ),
                AppConstants.kheight10,
                SizedBox(
                  height: MediaQuery.of(context).size.height * .04,
                ),
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        if (emailController.text == adminEmail &&
                            passController.text == adminPass) {
                          Navigator.of(context).push(createRoute(AdminHome()));
                        } else {
                          bool isDriver = await DriverService()
                              .checkEmailAndWorkCode(
                                  emailController.text, passController.text);

                          if (isDriver) {
                            // SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();
                            // final workerId = prefs.getString('WorkerId');
                            Navigator.of(context)
                                .push(createRoute(BottomNavigation()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                            customSnack('Invalid Crediential', 'Invalid credentials. Please try again.', Icon(Icons.error), Colors.red)
                            );
                          }
                        }
                      } catch (e) {
                        print('Error checking email and work code: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('An error occurred: $e')),
                        );
                      }
                    }
                  },
                  child: LoginContainer(
                    content: 'Login',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
