part of 'get_cart_details_user_bloc.dart';

sealed class GetWorkerEvent extends Equatable {
  const GetWorkerEvent();

  @override
  List<Object> get props => [];
}
final class FetchWorkerData  extends GetWorkerEvent{

}
final class FetchedWorkerData extends GetWorkerEvent{
  List<DocumentSnapshot>data;
  FetchedWorkerData(this.data);
 @override
  List<Object> get props => [data];
}