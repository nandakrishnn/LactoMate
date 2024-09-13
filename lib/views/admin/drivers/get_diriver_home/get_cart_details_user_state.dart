part of 'get_cart_details_user_bloc.dart';

sealed class GetDriverDetailsState extends Equatable {
  const GetDriverDetailsState();
  
  @override
  List<Object> get props => [];
}

final class GetWorkerInitial extends GetDriverDetailsState {}
final class GetWorkerLoading extends GetDriverDetailsState {}
final class GetWorkerLoaded extends GetDriverDetailsState {
  final List<DocumentSnapshot>data;
  GetWorkerLoaded(this.data);
    @override
  List<Object> get props => [data];
}
final class GetWorkerLoadingFailure extends GetDriverDetailsState {
  final String errorMsg;
  GetWorkerLoadingFailure(this.errorMsg);
    @override
  List<Object> get props => [errorMsg];
}