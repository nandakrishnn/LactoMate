part of 'route_shops_list_addition_bloc.dart';
enum RouteDetailsUploadStatus{inital,pending,sucess,failure}
 class RouteShopsListAdditionState {
  RouteShopsListAdditionState({this.id,this.routeName,this.shopDetails,this.status,this.assignedDriver});
  String? id='';
  String? routeName='';
  String?assignedDriver='';
  List<Map<String,dynamic>>?shopDetails=[];
  RouteDetailsUploadStatus? status;
  RouteShopsListAdditionState copyWith({
  String? id,
  String? routeName,
    String?assignedDriver,
  List<Map<String,dynamic>>?shopDetails,
  RouteDetailsUploadStatus? status,
  })=>RouteShopsListAdditionState(
    assignedDriver: assignedDriver??this.assignedDriver,
    id: id??this.id,
    routeName: routeName??this.routeName,
    shopDetails: shopDetails??this.shopDetails,
    status: status??this.status,
    
  );
 }