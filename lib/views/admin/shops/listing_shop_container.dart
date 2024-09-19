import 'package:flutter/material.dart';
import 'package:lactomate/utils/colors.dart';
import 'package:lactomate/utils/constants.dart';
import 'package:lactomate/widgets/three_dots.dart';
import 'package:lactomate/widgets/three_shop_dots.dart';

class PaymentItem extends StatelessWidget {
  final data;
  final String title;
  final String? category;
  final String imageUrl;
  final String deliveryStamp;
  final String amount;

  const PaymentItem(
      {super.key,
      required this.title,
      this.category,
      required this.imageUrl,
      required this.amount, this.data, required this.deliveryStamp});

  @override
  Widget build(BuildContext context) {
    // print(data['DeliveryTimeStamp']);
    // print(amount);
    // print(deliveryStamp);
    return Container(
      height: 150,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: const Color(0xFF2c3135),
          boxShadow: [
            BoxShadow(
                color: Colors.white.withOpacity(0.05),
                offset: const Offset(-10, -10),
                spreadRadius: 0,
                blurRadius: 10),
            BoxShadow(
                color: Colors.black87.withOpacity(0.3),
                offset: const Offset(10, 10),
                spreadRadius: 0,
                blurRadius: 10)
          ]),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12), // Added padding
            child: SizedBox(
              height: 90,
              width: 90,
              child: NeumorphicCircle(
                img: imageUrl,
                innerShadow: false,
                outerShadow: true,
                backgroundColor: const Color(0xFF2c3135),
                shadowColor: Colors.black87,
                highlightColor: Colors.white.withOpacity(0.05),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                      DropDownMenuSubCatgeoryShop(
             data: data,
                          color: AppColors.appcolorCream,
                          icon: Icon(
                            Icons.more_vert,
                            color: AppColors.appcolorCream,
                          ),
                        )
                    
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
             
                Row(
             
                  children: [
                    const Text(
                      'PayLoad', // Added label for the amount
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    AppConstants.kwidth10,
                    Text(
                      amount,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                // Text('Delivered on: '+deliveryStamp,
                //       style: const TextStyle(
                //           color: Colors.white,
                //           fontSize: 14,

                //           fontWeight: FontWeight.w600),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NeumorphicCircle extends StatelessWidget {
  final bool innerShadow;
  final bool outerShadow;
  final Color highlightColor;
  final Color shadowColor;
  final Color backgroundColor;
  final Widget? child;
  final String img;

  const NeumorphicCircle(
      {super.key,
      required this.innerShadow,
      required this.outerShadow,
      required this.highlightColor,
      required this.shadowColor,
      required this.backgroundColor,
      this.child, required this.img});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
          decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              boxShadow: (outerShadow)
                  ? [
                      BoxShadow(
                          color: highlightColor,
                          offset: const Offset(-10, -10),
                          blurRadius: 20,
                          spreadRadius: 0),
                      BoxShadow(
                          color: shadowColor,
                          offset: const Offset(10, 10),
                          blurRadius: 20,
                          spreadRadius: 0)
                    ]
                  : null)),
      (innerShadow)
          ? ClipPath(
              clipper: HighlightClipper(),
              child: CircleInnerHighlight(
img: img,
                highlightColor: highlightColor,
                backgroundColor: backgroundColor,
              ))
          : const SizedBox.shrink(),
      (innerShadow)
          ? ClipPath(
              clipper: ShadowClipper(),
              child: CircleInnerShadow(
                shadowColor: shadowColor,
                backgroundColor: backgroundColor,
              ),
            )
          : const SizedBox.shrink(),
      (child != null) ? child! : const SizedBox.shrink()
    ]);
  }
  
}
class CircleInnerShadow extends StatelessWidget {
  final Color shadowColor;
  final Color backgroundColor;

  const CircleInnerShadow(
      {super.key, required this.shadowColor, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            backgroundColor,
            shadowColor,
          ],
          center: const AlignmentDirectional(0.05, 0.05),
          focal: const AlignmentDirectional(0, 0),
          radius: 0.5,
          focalRadius: 0,
          stops: const [0.75, 1.0],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 0.45],
                colors: [backgroundColor.withOpacity(0), backgroundColor])),
      ),
    );
  }
}

class CircleInnerHighlight extends StatelessWidget {
  final Color highlightColor;
  final Color backgroundColor;
  final String img;

  const CircleInnerHighlight(
    
      {super.key, required this.highlightColor, required this.backgroundColor, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            backgroundColor,
            highlightColor,
          ],
          center: const AlignmentDirectional(-0.05, -0.05),
          focal: const AlignmentDirectional(-0.05, -0.05),
          radius: 0.6,
          focalRadius: 0.1,
          stops: const [0.75, 1.0],
        ),
      ),
      
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.55, 1],
                colors: [backgroundColor, backgroundColor.withOpacity(0)])),
                child: Image.network(img,fit: BoxFit.cover,),
      ),
      
    );
  }
}

class ShadowClipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }
}

class HighlightClipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }
}
