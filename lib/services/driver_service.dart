import 'package:cloud_firestore/cloud_firestore.dart';

class DriverService{

  Future<bool>saveDriverDetils(String id,Map<String,dynamic>driverDetails)async{
  try {
    await FirebaseFirestore.instance.collection("DriverDetails").doc(id).set(driverDetails);
    return true;
  } catch (e) {
    return false;
  }
 }
Map<String,dynamic>workerDetails({
required String id,
required String driverImg,
required String driverName,
required String driverEmail,
required int driverPhone,
required String driverLicenseImg,
required String driverDob,

}){
Map<String,dynamic>workerDetails={
'DriverId':id,
'DriverImg':driverImg,
'DriverName':driverName,
'DriverEmail':driverEmail,
'DriverPhone':driverPhone,
'DriverLicenseImg':driverLicenseImg,
'DriverDob':driverDob
};
return workerDetails;
}
}