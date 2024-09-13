import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:lactomate/services/driver_service.dart';


part 'get_cart_details_user_event.dart';
part 'get_cart_details_user_state.dart';

class GetWorkerDetailsUserBloc extends Bloc<GetWorkerEvent, GetDriverDetailsState> {
   final DriverService driverService;
  GetWorkerDetailsUserBloc(this.driverService) : super(GetWorkerInitial()) {
  
on<FetchWorkerData>(_fetchcartdata);
on<FetchedWorkerData>(_fetchedData);
  }
  void _fetchcartdata(FetchWorkerData event,Emitter<GetDriverDetailsState>emit)async{
    emit(GetWorkerLoading());
    try {
      Stream<QuerySnapshot>cartStream= driverService.getWorkerDetails();
      cartStream.listen((snapshots){
          final data=snapshots.docs;
          add(FetchedWorkerData(data));
      });
    } catch (e) {
      emit(GetWorkerLoadingFailure(e.toString()));
    }
  }
  void _fetchedData(FetchedWorkerData event,Emitter<GetDriverDetailsState>emit){
    emit(GetWorkerLoaded(event.data));
  }
}
