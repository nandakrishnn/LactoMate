import 'package:bloc/bloc.dart';
import 'package:lactomate/services/driver_service.dart';
import 'package:random_string/random_string.dart';

part 'add_driver_details_event.dart';
part 'add_driver_details_state.dart';

class AddDriverDetailsBloc
    extends Bloc<AddDriverDetailsEvent, AddDriverDetailsState> {
  final DriverService driverService;
  AddDriverDetailsBloc(this.driverService) : super(AddDriverDetailsState()) {
    on<DriverImageChnages>(_driverimageChnages);
    on<DriverNameChanges>(_driverNameChnages);
    on<DriverPhoneChnages>(_driverPhoneChnages);
    on<DriverEmailChnages>(_driverEmailChnages);
    on<DriverLicenseImageChnages>(_driverLicenseImgChnages);
    on<DriverDobChnages>(_driverDobChnages);
    on<DriverId>(_driverId);
    on<DriverRouteChnages>(_driverRouteChnages);
    on<DriverFormSubmit>(_formSubmit);
  }
  void _driverimageChnages(
      DriverImageChnages event, Emitter<AddDriverDetailsState> emit) {
        print(state.driverImg);
    emit(state.copyWith(driverImg: event.img));
  }

  void _driverNameChnages(
      DriverNameChanges event, Emitter<AddDriverDetailsState> emit) {
    emit(state.copyWith(driverName: event.driverName));
  }
    void _driverRouteChnages(
      DriverRouteChnages event, Emitter<AddDriverDetailsState> emit) {
    emit(state.copyWith(driverRoute: event.driverRoute));
  }
   void _driverId(
      DriverId event, Emitter<AddDriverDetailsState> emit) {
    emit(state.copyWith(driverId: event.driverId));
  }

  void _driverPhoneChnages(
      DriverPhoneChnages event, Emitter<AddDriverDetailsState> emit) {
    emit(state.copyWith(driverPhone: event.driverPhone));
  }

  void _driverEmailChnages(
      DriverEmailChnages event, Emitter<AddDriverDetailsState> emit) {
    emit(state.copyWith(driverEmail: event.driverEmail));
  }

  void _driverLicenseImgChnages(
      DriverLicenseImageChnages event, Emitter<AddDriverDetailsState> emit) {
    emit(state.copyWith(driverLicenseImg: event.driverLicenseImg));
  }

  void _driverDobChnages(
      DriverDobChnages event, Emitter<AddDriverDetailsState> emit) {
    emit(state.copyWith(driverDob: event.driverDob));
  }

  void _formSubmit(
      DriverFormSubmit event, Emitter<AddDriverDetailsState> emit) async {
    emit(state.copyWith(status: DriverUploadStatus.inital));
    try {
      final id = randomAlphaNumeric(6);
      final driverMap = driverService.workerDetails(
        driverRoute: state.driverRoute!,
        driverCode: state.driverId!,
          id: id,
          driverImg: state.driverImg!,
          driverName: state.driverName!,
          driverEmail: state.driverEmail!,
          driverPhone: state.driverPhone!,
          driverLicenseImg: state.driverLicenseImg!,
          driverDob: state.driverDob!);
      final added = await driverService.saveDriverDetils(id, driverMap);
      if (added == true) {
       emit( state.copyWith(status: DriverUploadStatus.sucess));
      } else {
        emit(state.copyWith(status: DriverUploadStatus.failure));
      }
    } catch (e) {
       emit(state.copyWith(status: DriverUploadStatus.failure));
    }
  }
}
