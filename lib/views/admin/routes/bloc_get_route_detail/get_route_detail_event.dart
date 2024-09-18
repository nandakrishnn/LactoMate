// ignore_for_file: must_be_immutable

part of 'get_route_detail_bloc.dart';

sealed class GetRouteDetailEvent extends Equatable {
  const GetRouteDetailEvent();

  @override
  List<Object> get props => [];
}
class FetchRouteDetails extends GetRouteDetailEvent{

}
class FetchedRouteDetails extends GetRouteDetailEvent{
 List<DocumentSnapshot>data;
  FetchedRouteDetails(this.data);
    @override
  List<Object> get props => [data];
}
class FetchedRouteDetailsDriver extends GetRouteDetailEvent{
 List<Map<String,dynamic>>data;
  FetchedRouteDetailsDriver(this.data);
    @override
  List<Object> get props => [data];
}
class FetchDriverData extends GetRouteDetailEvent{
  String workerId;
  FetchDriverData(this.workerId);
}