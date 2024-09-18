import 'package:cloud_firestore/cloud_firestore.dart';

class RouteService{
  Future<bool>saveRoueDetails(String id,Map<String,dynamic>shopDetails)async{
    try {
      await FirebaseFirestore.instance.collection("RouteDetails").doc(id).set(shopDetails);
    return true;
    } catch (e) {
      return false;
    }
  }
  Map<String,dynamic>shopDetails({
required String id,
required String routeName,
required String driverId,
required List<Map<String,dynamic>>shopDetails1,

}){
Map<String,dynamic>shopDetails={
'RouteName':routeName,
'AssignedDriver':driverId,
'RouteId':id,
'RouteDetails':shopDetails1

};
return shopDetails;
}
Stream<QuerySnapshot<Object?>> getRouteDetails(){
  return FirebaseFirestore.instance.collection("RouteDetails").snapshots();

}
Stream<QuerySnapshot> getDriverRouteDetails(String id) {
  return FirebaseFirestore.instance
      .collection("RouteDetails")
      .where('AssignedDriver', isEqualTo: id)
      .snapshots();
}

}
