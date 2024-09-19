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
required String shopName,
required String shopImage,
 required   dynamic shopWeight,
 required dynamic timeStamp,
 required dynamic shopAdress,
 required dynamic latitiude,
 required dynamic longitue,

}){
Map<String,dynamic>shopDetails={
'DeliveryTimeStamp':timeStamp,
'ShopName':shopName,
'ShopId':id,
'ShopImage':shopImage,
'ShopAdress':shopAdress,
'PayLoad':shopWeight,
'Longitude':longitue,
'Latitude':latitiude,

};
return shopDetails;
}
Stream<QuerySnapshot<Object?>> getShopDetails(){
  return FirebaseFirestore.instance.collection("ShopDetails").snapshots();

}
}