import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shop_details_addition_event.dart';
part 'shop_details_addition_state.dart';

class ShopDetailsAdditionBloc extends Bloc<ShopDetailsAdditionEvent, ShopDetailsAdditionState> {
  ShopDetailsAdditionBloc() : super(ShopDetailsAdditionState()) {
   on<ShopNameChnages>(_shopNameChanges);
   on<ShopImageChnages>(_shopImageChanges);
   on<ShopPayLoadChanges>(_shopPayLodChanges);
   on<ShopLatitudeChanges>(_shopLatitudeChanges);
   on<ShopLongitudeChanges>(_shopLongitudeChanges);
   on<ShopAdressChnages>(_shopAdressChanges);
   on<ShopFormSubmit>(_formSubmit);
  }
  void _shopNameChanges(ShopNameChnages event,Emitter<ShopDetailsAdditionState>emit){
    emit(state.copyWith(nameShop: event.name));
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
   void _formSubmit(ShopFormSubmit event,Emitter<ShopDetailsAdditionState>emit){
    emit(state.copyWith(status: ShopDetailsStatus.pending));
    try {
      
    } catch (e) {
      
    }
  }
}
