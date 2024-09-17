part of 'route_shops_list_addition_bloc.dart';

 class RouteShopsListAdditionEvent {}
class RouteNameChanges extends RouteShopsListAdditionEvent{
  final String routeName;
  RouteNameChanges(this.routeName);
}
class RouteIdChanges extends RouteShopsListAdditionEvent{
  final String routeId;
  RouteIdChanges(this.routeId);
}
class DriverIdChanges extends RouteShopsListAdditionEvent{
  final String driverId;
  DriverIdChanges(this.driverId);
}
class ShopDetailsChanges extends RouteShopsListAdditionEvent{
  final List<Map<String,dynamic>>shopDetails;
  ShopDetailsChanges(this.shopDetails);
}
class ShopFormSubmit extends RouteShopsListAdditionEvent{}