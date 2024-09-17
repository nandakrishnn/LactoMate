part of 'get_shop_details_bloc.dart';

sealed class GetShopDetailsState extends Equatable {
  const GetShopDetailsState();
  
  @override
  List<Object> get props => [];
}

final class GetShopDetailsInitial extends GetShopDetailsState {}
final class GetShopDetailsLoading extends GetShopDetailsState {}
final class GetShopDetailsLoaded extends GetShopDetailsState {
  List<DocumentSnapshot>data;
  GetShopDetailsLoaded(this.data);
     @override
  List<Object> get props => [data];
}
final class GetShopDetailsFailrue extends GetShopDetailsState {
    final String errorMsg;
  GetShopDetailsFailrue(this.errorMsg);
    @override
  List<Object> get props => [errorMsg];
}