import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverService{

  Future<bool>saveDriverDetils(String id,Map<String,dynamic>driverDetails)async{
  try {
    await FirebaseFirestore.instance.collection("DriverDetails").doc(id).set(driverDetails);
    return true;
  } catch (e) {
    return false;
  }
 }
 Future<Map<String,dynamic>>getDriverDetail(String id)async{
  final querySnapshot= await FirebaseFirestore.instance.collection("DriverDetails").doc(id).get();
  return querySnapshot.data() as Map<String,dynamic>;
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
  Future<bool> checkEmailAndWorkCode(String email, String workCode) async {
    try {
      CollectionReference workersCollection =
          FirebaseFirestore.instance.collection('DriverDetails');

      QuerySnapshot querySnapshot = await workersCollection
          .where('DriverEmail', isEqualTo: email)
          .where('DriverCode', isEqualTo: workCode)
          .get();

      final dynamic documentId = querySnapshot.docs.first.id;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('WorkerId', documentId);

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking email and work code: $e");
      return false;
    }
  }


}