import 'package:bloc/bloc.dart';
import 'package:lactomate/services/shop_service.dart';
import 'package:random_string/random_string.dart';

part 'shop_details_addition_event.dart';
part 'shop_details_addition_state.dart';

class ShopDetailsAdditionBloc extends Bloc<ShopDetailsAdditionEvent, ShopDetailsAdditionState> {
  final ShopService shopService;
  ShopDetailsAdditionBloc(this.shopService) : super(ShopDetailsAdditionState()) {
   on<ShopNameChnages>(_shopNameChanges);
   on<ShopImageChnages>(_shopImageChanges);
   on<ShopPayLoadChanges>(_shopPayLodChanges);
   on<ShopLatitudeChanges>(_shopLatitudeChanges);
   on<ShopLongitudeChanges>(_shopLongitudeChanges);
   on<ShopAdressChnages>(_shopAdressChanges);
    on<ShopTimeStamp>(_shoptimeStamp);
   on<ShopFormSubmit>(_formSubmit);
  }
  void _shopNameChanges(ShopNameChnages event,Emitter<ShopDetailsAdditionState>emit){
    emit(state.copyWith(nameShop: event.name));
  }
    void _shoptimeStamp(ShopTimeStamp event,Emitter<ShopDetailsAdditionState>emit){
    emit(state.copyWith(deliveryStatus: event.timestamp));
  }
   void _shopImageChanges(ShopImageChnages event,Emitter<ShopDetailsAdditionState>emit){
    emit(state.copyWith(imgurl: event.image));
  }
     void _shopPayLodChanges(ShopPayLoadChanges event,Emitter<ShopDetailsAdditionState>emit){
    emit(state.copyWith(shopWeight: event.payload));
  }
    void _shopLatitudeChanges(ShopLatitudeChanges event,Emitter<ShopDetailsAdditionState>emit){
    emit(state.copyWith(latitiude: event.latitude));
  }
   void _shopLongitudeChanges(ShopLongitudeChanges event,Emitter<ShopDetailsAdditionState>emit){
    emit(state.copyWith(longitue: event.longitude));
  }
   void _shopAdressChanges(ShopAdressChnages event,Emitter<ShopDetailsAdditionState>emit){
    emit(state.copyWith(shopAdress: event.adress));
  }
   void _formSubmit(ShopFormSubmit event,Emitter<ShopDetailsAdditionState>emit)async{
    emit(state.copyWith(status: ShopDetailsStatus.pending));
    try {
      final id=randomAlphaNumeric(5);
      final shopDetails= shopService.shopDetails(
        timeStamp: state.deliveryStatus,
        id: id, shopName: state.nameShop!, shopImage: state.imgurl!, shopWeight: state.shopWeight, shopAdress: state.shopAdress, latitiude: state.latitiude, longitue: state.longitue);
          final added=await shopService.saveDriverDetils(id, shopDetails);
          if(added==true){
            emit(state.copyWith(status: ShopDetailsStatus.sucess));
          }else{
                emit(state.copyWith(status: ShopDetailsStatus.failure));
          }
    } catch (e) {
       emit(state.copyWith(status: ShopDetailsStatus.failure));
    }
  }
}
