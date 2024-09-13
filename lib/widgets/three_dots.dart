import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DropDownMenuSubCatgeory extends StatelessWidget {
  final Color color;
  final Widget icon;
  final dynamic data;
  final mainCatId;
  const DropDownMenuSubCatgeory({
    required this.data,
    this.color = Colors.white,
    this.icon = const Icon(
      Icons.more_vert,
      color: Colors.black,
    ),
    
    super.key,
    this.mainCatId,
  });

  @override
  Widget build(BuildContext context) {
print(data['DriverId'].toString());
    return PopupMenuButton(
      color: color,
      icon: icon,
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: ListTile(
            onTap: ()async {
            },
            leading: Icon(Icons.edit, color: Color(0xff4338CA)),
            title: Text(
              'Edit',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          child: ListTile(
            onTap: () async {
             await FirebaseFirestore.instance.collection("DriverDetails").doc(data['DriverId']).delete();

            },
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        )
      ],
    );
  }
}