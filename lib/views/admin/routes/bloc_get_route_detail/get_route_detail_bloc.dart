import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:lactomate/services/route_service.dart';

part 'get_route_detail_event.dart';
part 'get_route_detail_state.dart';

class GetRouteDetailBloc extends Bloc<GetRouteDetailEvent, GetRouteDetailState> {
  final RouteService routeService;
  GetRouteDetailBloc(this.routeService) : super(GetRouteDetailInitial()) {
   on<FetchRouteDetails>(_fetchRouteDetails);
   on<FetchedRouteDetails>(_fetchedRouteDetails);
  }
    void _fetchRouteDetails(FetchRouteDetails event,Emitter<GetRouteDetailState>emit)async{
      emit(GetRouteDetailLoading());
      try {
        Stream<QuerySnapshot>routeStream= routeService.getRouteDetails();
        routeStream.listen((snapshot){
          final data=snapshot.docs;
          add(FetchedRouteDetails(data));
        });
      } catch (e) {
        emit(GetRouteDetailFailure(e.toString()));
      }
    }
    void _fetchedRouteDetails(FetchedRouteDetails event,Emitter<GetRouteDetailState>emit){
      emit(GetRouteDetailLoaded(event.data));
    }
}
