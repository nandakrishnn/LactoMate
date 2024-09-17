import 'package:bloc/bloc.dart';
import 'package:lactomate/services/route_service.dart';
import 'package:random_string/random_string.dart';
part 'route_shops_list_addition_event.dart';
part 'route_shops_list_addition_state.dart';

class RouteShopsListAdditionBloc extends Bloc<RouteShopsListAdditionEvent, RouteShopsListAdditionState> {
  final RouteService routeService;
  RouteShopsListAdditionBloc(this.routeService) : super(RouteShopsListAdditionState()) {

 on<RouteNameChanges>(_routeNameChnages);
 on<ShopDetailsChanges>(_shopDetailsChnages);
 on<ShopFormSubmit>(_formSubmit);
  }
 
   void _routeNameChnages(RouteNameChanges event,Emitter<RouteShopsListAdditionState>emit){
    emit(state.copyWith(routeName: event.routeName));
  }
     void _shopDetailsChnages(ShopDetailsChanges event,Emitter<RouteShopsListAdditionState>emit){
    emit(state.copyWith(shopDetails: event.shopDetails));
  }
   void _formSubmit(ShopFormSubmit event,Emitter<RouteShopsListAdditionState>emit)async{
    emit(state.copyWith(status: RouteDetailsUploadStatus.pending));
    try {
      final id=randomAlphaNumeric(10);
      final ShopDetails=routeService.shopDetails(id: id, routeName: state.routeName!, shopDetails1: state.shopDetails!);
      final added=await routeService.saveRoueDetails(id, ShopDetails);
      if(added==true){
          emit(state.copyWith(status: RouteDetailsUploadStatus.sucess));
      }else{
         emit(state.copyWith(status: RouteDetailsUploadStatus.failure));
      }
    } catch (e) {
        emit(state.copyWith(status: RouteDetailsUploadStatus.failure));
    }
  }
}
