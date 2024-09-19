import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lactomate/utils/constants.dart';  

class RouteItemContainer extends StatefulWidget {
  final Map<String, dynamic> routeDetail;
  final id;
  const RouteItemContainer({super.key, required this.routeDetail, this.id,});

  @override
  _RouteItemContainerState createState() => _RouteItemContainerState();
}

class _RouteItemContainerState extends State<RouteItemContainer> {

  bool isChecked = false;
  String? formattedTimestamp;

  void _showConfirmationDialog() async {
    bool? confirmDelivery = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        print(widget.routeDetail['RouteId']);
        return AlertDialog(
          title: Text('Confirm Delivery'),
          content: Text('Are you sure you have delivered the payload?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
                setState(() {
                  isChecked = true;
                  // Format the timestamp
                  formattedTimestamp = DateFormat('hh:mm a, dd MMM yyyy').format(DateTime.now());
                });
                await _updateDeliveryTimeStamp();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateDeliveryTimeStamp() async {
   

final shopoName=widget.routeDetail['ShopName'];
    final routeId = widget.id;

    final firestore = FirebaseFirestore.instance;

    // Fetch the route document
    final routeDoc = await firestore.collection('RouteDetails').doc(routeId).get();
    if (!routeDoc.exists) return;

    final routeData = routeDoc.data();
    if (routeData == null || !routeData.containsKey('RouteDetails')) return;

    final routeDetails = List<Map<String, dynamic>>.from(routeData['RouteDetails']);

    // Find and update the DeliveryTimeStamp for the specific shop
    for (var routeDetail in routeDetails) {
      if (routeDetail['ShopName'] == shopoName) {
        routeDetail['DeliveryTimeStamp'] = formattedTimestamp;
        break;
      }
    }

    // Update the document with the new RouteDetails
    await firestore.collection('RouteDetails').doc(routeId).update({
      'RouteDetails': routeDetails,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isChecked ? Colors.grey[300] : Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.routeDetail['ShopName'] ?? 'Shop Name',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          widget.routeDetail['ShopAdress'] ?? 'Shop Address',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                          SizedBox(height: 4),
                        Text(
                        'PayLoad : '+  widget.routeDetail['PayLoad'] +' Kg'?? 'Shop Address',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600],fontWeight: FontWeight.w600,),
                          maxLines: 2,
                          
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  CustomCheckbox(
                    isChecked: isChecked,
                    onChanged: (bool? value) {
                      if (isChecked) {
                        return;
                      }
                      _showConfirmationDialog();
                    },
                  ),
                ],
              ),
              if (formattedTimestamp != null) ...[
                SizedBox(height: 10),
                Text(
                  'Completed at: $formattedTimestamp',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
          
              ],
            ],
          ),
        ),
        AppConstants.kheight20
      ],
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const CustomCheckbox({super.key, required this.isChecked, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.maximumDensity,
        vertical: VisualDensity.maximumDensity,
      ),
      value: isChecked,
      onChanged: onChanged,
      checkColor: Colors.black,
      activeColor: Colors.amber,
      side: BorderSide(
        color: isChecked ? Colors.grey : Colors.grey,
        width: 2.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}
