  import 'package:flutter/material.dart';
import 'package:lactomate/utils/constants.dart';

SnackBar customSnack(String maintext,String subtext,Icon snackIcon,Color maincolor) {
    
    return SnackBar(
                    elevation: 20,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    dismissDirection: DismissDirection.down,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    content:  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                               snackIcon,
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                 maintext,
                                    style:  TextStyle(
                                      color: maincolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              AppConstants.kheight15,
                              Text(
                                subtext,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
  }

