part of 'shop_details_addition_bloc.dart';

 class ShopDetailsAdditionEvent {

 }
  final class ShopNameChnages extends ShopDetailsAdditionEvent{
    final String name;
    ShopNameChnages(this.name);
  }

  final class ShopImageChnages extends ShopDetailsAdditionEvent{
    final String image;
    ShopImageChnages(this.image);
  }
  
  final class ShopPayLoadChanges extends ShopDetailsAdditionEvent{
    final dynamic payload;
    ShopPayLoadChanges(this.payload);
  }
   final class ShopLatitudeChanges extends ShopDetailsAdditionEvent{
    final dynamic latitude;
    ShopLatitudeChanges(this.latitude);
  }
   final class ShopLongitudeChanges extends ShopDetailsAdditionEvent{
    final dynamic longitude ;
    ShopLongitudeChanges(this.longitude);
  }
     final class ShopAdressChnages extends ShopDetailsAdditionEvent{
    final dynamic adress ;
    ShopAdressChnages(this.adress);
  }
       final class ShopTimeStamp extends ShopDetailsAdditionEvent{
    final dynamic timestamp ;
    ShopTimeStamp(this.timestamp);
  }
  final class UpdateShopFormSubmit extends ShopDetailsAdditionEvent{
UpdateShopFormSubmit({
required this.name,
required this.adress,
required this.image,
required this.latitude,
required this.longitude,
required this.id,
required this.payload,
});
    final String name;
        final String image;
            final dynamic payload;
                final dynamic latitude;
                    final dynamic longitude ;
                    final String id;
                        final dynamic adress ;
  }

  final class ShopFormSubmit extends ShopDetailsAdditionEvent{

  }