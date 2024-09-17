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
required String driverRoute,
required int driverPhone,
required String driverLicenseImg,
required String driverDob,
required String driverCode,

}){
Map<String,dynamic>workerDetails={
'DriverCode':driverCode,
'DriverId':id,
'DriverRoute':driverRoute,
'DriverImg':driverImg,
'DriverName':driverName,
'DriverEmail':driverEmail,
'DriverPhone':driverPhone,
'DriverLicenseImg':driverLicenseImg,
'DriverDob':driverDob
};
return workerDetails;
}

Stream<QuerySnapshot<Object?>> getWorkerDetails(){
  return FirebaseFirestore.instance.collection("DriverDetails").snapshots();

}

}