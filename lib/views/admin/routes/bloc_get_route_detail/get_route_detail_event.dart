part of 'get_route_detail_bloc.dart';

sealed class GetRouteDetailEvent extends Equatable {
  const GetRouteDetailEvent();

  @override
  List<Object> get props => [];
}
class FetchRouteDetails extends GetRouteDetailEvent{

// ignore: must_be_immutable
}class FetchedRouteDetails extends GetRouteDetailEvent{
 List<DocumentSnapshot>data;
  FetchedRouteDetails(this.data);
    @override
  List<Object> get props => [data];
}