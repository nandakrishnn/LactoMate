part of 'route_shops_list_addition_bloc.dart';
enum RouteDetailsUploadStatus{inital,pending,sucess,failure}
 class RouteShopsListAdditionState {
  RouteShopsListAdditionState({this.id,this.routeName,this.shopDetails,this.status});
  String? id='';
  String? routeName='';
  List<Map<String,dynamic>>?shopDetails=[];
  RouteDetailsUploadStatus? status;
  RouteShopsListAdditionState copyWith({
  String? id,
  String? routeName,
  List<Map<String,dynamic>>?shopDetails,
  RouteDetailsUploadStatus? status,
  })=>RouteShopsListAdditionState(
    id: id??this.id,
    routeName: routeName??this.routeName,
    shopDetails: shopDetails??this.shopDetails,
    status: status??this.status
  );
 }