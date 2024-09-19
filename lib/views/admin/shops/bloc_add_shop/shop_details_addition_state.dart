part of 'shop_details_addition_bloc.dart';

enum ShopDetailsStatus { inital, pending, sucess, failure }

class ShopDetailsAdditionState {
  ShopDetailsAdditionState(
      {this.id = '',
      this.imgurl = '',
      this.nameShop = '',
      this.latitiude = '',
      this.shopAdress = '',
      this.deliveryStatus='',
      this.longitue = '',
      this.status = ShopDetailsStatus.inital,
      this.shopWeight = 0});
  String? id;
  String? imgurl;
  String? nameShop;
  dynamic shopWeight;
  dynamic shopAdress;
  dynamic latitiude;
  ShopDetailsStatus status;
  dynamic longitue;
  dynamic deliveryStatus;
  ShopDetailsAdditionState copyWith({
    String? id,
    String? imgurl,
    String? nameShop,
    dynamic deliveryStatus,
    dynamic shopWeight,
    dynamic shopAdress,
    dynamic latitiude,
    dynamic longitue,
    ShopDetailsStatus? status,

  }) =>
      ShopDetailsAdditionState(
        deliveryStatus: deliveryStatus??this.deliveryStatus,
          status: status ?? this.status,
          id: id ?? this.id,
          imgurl: imgurl ?? this.imgurl,
          nameShop: nameShop ?? this.nameShop,
          shopWeight: shopWeight ?? this.shopWeight,
          shopAdress: shopAdress ?? this.shopAdress,
          latitiude: latitiude ?? this.latitiude,
          longitue: longitue ?? this.longitue);
}
