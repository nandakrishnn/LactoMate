import 'package:cloud_firestore/cloud_firestore.dart';

class ShopService{
   Future<bool>saveDriverDetils(String id,Map<String,dynamic>shopDetails)async{
  try {
    await FirebaseFirestore.instance.collection("ShopDetails").doc(id).set(shopDetails);
    return true;
  } catch (e) {
    return false;
  }
 }
Map<String,dynamic>shopDetails({
required String id,
required String driverImg,
required String driverName,
required String driverEmail,
required int driverPhone,
required String driverLicenseImg,
required String driverDob,
required String driverCode,

}){
Map<String,dynamic>shopDetails={
'DriverCode':driverCode,
'ShopId':id,
'DriverImg':driverImg,
'DriverName':driverName,
'DriverEmail':driverEmail,
'DriverPhone':driverPhone,
'DriverLicenseImg':driverLicenseImg,
'DriverDob':driverDob
};
return shopDetails;
}

}