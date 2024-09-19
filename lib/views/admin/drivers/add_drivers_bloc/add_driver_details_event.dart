part of 'add_driver_details_bloc.dart';

class AddDriverDetailsEvent {}

final class DriverImageChnages extends AddDriverDetailsEvent {
  final String img;
  DriverImageChnages(this.img);
}

final class DriverNameChanges extends AddDriverDetailsEvent {
  final String driverName;
  DriverNameChanges(this.driverName);
}

final class DriverPhoneChnages extends AddDriverDetailsEvent {
  final int driverPhone;
  DriverPhoneChnages(this.driverPhone);
}

final class DriverEmailChnages extends AddDriverDetailsEvent {
  final String driverEmail;
  DriverEmailChnages(this.driverEmail);
}

final class DriverLicenseImageChnages extends AddDriverDetailsEvent {
  final String driverLicenseImg;
  DriverLicenseImageChnages(this.driverLicenseImg);
}

final class DriverDobChnages extends AddDriverDetailsEvent {
  final String driverDob;
  DriverDobChnages(this.driverDob);
}

final class DriverRouteChnages extends AddDriverDetailsEvent {
  final String driverRoute;
  DriverRouteChnages(this.driverRoute);
}

final class DriverId extends AddDriverDetailsEvent {
  final String driverId;
  DriverId(this.driverId);
}

final class UpdateFormSubmitDriver extends AddDriverDetailsEvent {
  final String img;
  final String driverName;
  final int driverPhone;
  final String id;
  final String driverEmail;
  final String driverLicenseImg;
  final String driverDob;

  final String driverId;
  UpdateFormSubmitDriver({
    required this.id,
    required this.img,
    required this.driverName,
    required this.driverPhone,

    required this.driverEmail,
    required this.driverLicenseImg,
    required this.driverDob,
    required this.driverId,
  });
}

final class DriverFormSubmit extends AddDriverDetailsEvent {}
