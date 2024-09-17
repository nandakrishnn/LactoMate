import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:lactomate/services/shop_service.dart';

part 'get_shop_details_event.dart';
part 'get_shop_details_state.dart';

class GetShopDetailsBloc extends Bloc<GetShopDetailsEvent, GetShopDetailsState> {
  final ShopService shopService;
  GetShopDetailsBloc(this.shopService) : super(GetShopDetailsInitial()) {
  on<FetchShopDetails>(_fetchData);
  on<FetchedShopDetails>(_fetchedata);

  
  }
void _fetchData(FetchShopDetails event,Emitter<GetShopDetailsState>emit){
 emit(GetShopDetailsLoading());
try {
  Stream<QuerySnapshot>shopStream=shopService.getShopDetails();
  shopStream.listen((snapshots){
    final data=snapshots.docs;
add(FetchedShopDetails(data));
  });
} catch (e) {
  emit(GetShopDetailsFailrue(e.toString()));
}

}

void _fetchedata(FetchedShopDetails event,Emitter<GetShopDetailsState>emit){
emit(GetShopDetailsLoaded(event.data));
}
}