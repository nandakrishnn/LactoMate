part of 'get_shop_details_bloc.dart';

sealed class GetShopDetailsEvent extends Equatable {
  const GetShopDetailsEvent();

  @override
  List<Object> get props => [];
}
final class FetchShopDetails extends GetShopDetailsEvent{}
final class FetchedShopDetails extends GetShopDetailsEvent{
  List<DocumentSnapshot>data;
  FetchedShopDetails(this.data);
    @override
  List<Object> get props => [data];
}