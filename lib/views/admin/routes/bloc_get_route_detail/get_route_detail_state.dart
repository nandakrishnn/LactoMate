part of 'get_route_detail_bloc.dart';

sealed class GetRouteDetailState extends Equatable {
  const GetRouteDetailState();
  
  @override
  List<Object> get props => [];
}

final class GetRouteDetailInitial extends GetRouteDetailState {}
final class GetRouteDetailLoading extends GetRouteDetailState {}
// ignore: must_be_immutable
final class GetRouteDetailLoaded extends GetRouteDetailState {
  List<DocumentSnapshot>data;
  GetRouteDetailLoaded(this.data);
   @override
  List<Object> get props => [data];
}
final class GetRouteDetailLoadedMap extends GetRouteDetailState {
  List<Map<String,dynamic>>data;
  GetRouteDetailLoadedMap(this.data);
   @override
  List<Object> get props => [data];
}
final class GetRouteDetailFailure extends GetRouteDetailState{
  final String errorMsg;
  GetRouteDetailFailure(this.errorMsg);
     @override
  List<Object> get props => [errorMsg];
}