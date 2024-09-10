

import 'package:flutter/material.dart';
import 'package:lactomate/utils/colors.dart';

class LoginContainer extends StatelessWidget {
  String content;
  void Function()? ontap;
  LoginContainer({
    this.ontap,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.appcolorTeal,
            borderRadius: BorderRadius.circular(7)),
        child: Center(
            child: Text(
          content,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        )),
      ),
    );
  }
}
