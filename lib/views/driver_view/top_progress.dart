import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';

class CustomStepper extends StatefulWidget {
  const CustomStepper({super.key});

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int activeStep = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: EasyStepper(
        direction: Axis.horizontal,
        activeStep: activeStep,
        stepShape: StepShape.circle,
        showStepBorder: false,
        borderThickness: 0,
        padding: const EdgeInsets.all(0),
        internalPadding: 0,
        stepRadius: 25,
        finishedStepBorderColor: Colors.white,
        finishedStepTextColor: Colors.white,
        finishedStepBackgroundColor: Colors.amber,
        activeStepIconColor: Colors.amber,
        showLoadingAnimation: false,
        steps: [
          EasyStep(
            customStep: CircleAvatar(
              backgroundColor: activeStep >= 0 ? Colors.amber : Colors.white,
              child: Icon(
                Icons.shopping_cart,
                color: activeStep >= 0 ? Colors.white : Colors.amber,
              ),
            ),
            title: 'Cart',
          ),
          EasyStep(
            customStep: CircleAvatar(
              backgroundColor: activeStep >= 1 ? Colors.amber : Colors.white,
              child: Icon(
                Icons.check,
                color: activeStep >= 1 ? Colors.white : Colors.amber,
              ),
            ),
            title: 'Delivery',
          ),
          EasyStep(
            customStep: CircleAvatar(
              backgroundColor: activeStep >= 2 ? Colors.amber : Colors.white,
              child: Icon(
                Icons.check,
                color: activeStep >= 2 ? Colors.white : Colors.amber,
              ),
            ),
            title: 'Completed',
          ),
        ],
        onStepReached: (index) => setState(() => activeStep = index),
      ),
    );
  }
}
