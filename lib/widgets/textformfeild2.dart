import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lactomate/utils/constants.dart';


import '../../../utils/colors.dart';

// ignore: must_be_immutable
class CustomTextFeild2 extends StatelessWidget {
  CustomTextFeild2(
      {
      required this.hinttext,
      this.sufixbutton,
      this.readOnly = false,
      this.prefixIcon,
      this.controller,
      this.keybordtype,
      super.key,
      this.tap,
      this.enabled = true,
      this.onChanged,
      required this.heading,
      this.obscure = false,
      this.validator});
  String hinttext;
  TextInputType? keybordtype;
  String heading;
  bool obscure;
  bool enabled;
  bool readOnly;
  Icon? sufixbutton;
  Icon? prefixIcon;
  TextEditingController? controller;
  String? Function(String?)? validator;
  void Function(String)? onChanged;
  void Function()? tap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(heading,
            style:  TextStyle(
              color: AppColors.appcolorBlack,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            )),
        AppConstants.kheight10,
        TextFormField(
          readOnly: readOnly,
          enabled: enabled,
          onChanged: onChanged,
          obscureText: obscure,
          controller: controller,
          keyboardType: keybordtype,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
              ),
              // focusColor: Colors.grey,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
              ),
              border: OutlineInputBorder(
                  gapPadding: 4,
                  borderSide: const BorderSide(
                      strokeAlign: BorderSide.strokeAlignCenter),
                  borderRadius: BorderRadius.circular(10)),
              hintText: hinttext,
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 174, 169, 169)),
              filled: true,
              fillColor: AppColors.appcolorCream,
              suffixIcon: sufixbutton != null
                  ? GestureDetector(onTap: tap, child: sufixbutton)
                  : null,
              prefixIcon: prefixIcon),
        ),
      ],
    );
  }
}

       // BackdropFilter(
            //   filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            //   child: Container(
            //     color: Colors.black.withOpacity(0.2),
            //   ),
            // ),