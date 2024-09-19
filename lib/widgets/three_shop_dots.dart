import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lactomate/views/admin/drivers/edit_driver_details.dart';
import 'package:lactomate/views/admin/shops/edit_shop_details.dart';
import 'package:lactomate/widgets/route_animations.dart';

class DropDownMenuSubCatgeoryShop extends StatelessWidget {
  final Color color;
  final Widget icon;
  final dynamic data;
  final mainCatId;
  const DropDownMenuSubCatgeoryShop({
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

    return PopupMenuButton(
      color: color,
      icon: icon,
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: ListTile(
            onTap: ()async {
              Navigator.of(context).push(createRoute(EditShopDetails(data: data,)));
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
         showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Are you sure you want to delete this Shop?"),
        actions: [
          TextButton(
            onPressed: () async {
              // Perform the delete operation
              await FirebaseFirestore.instance
                  .collection("ShopDetails")
                  .doc(data['ShopId'])
                  .delete();

              // Close the dialog after the operation
              Navigator.of(context).pop();
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              // Close the dialog without deleting
              Navigator.of(context).pop();
            },
            child: Text('No'),
          ),
        ],
      );
    },
  );
            
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