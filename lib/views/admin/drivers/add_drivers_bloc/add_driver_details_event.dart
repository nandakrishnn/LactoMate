part of 'add_driver_details_bloc.dart';

 class AddDriverDetailsEvent{}
 final class DriverImageChnages extends AddDriverDetailsEvent{
  final String img;
  DriverImageChnages(this.img);
 }
 final class DriverNameChanges extends AddDriverDetailsEvent{
  final String driverName;
  DriverNameChanges(this.driverName);
 }
 final class DriverPhoneChnages extends AddDriverDetailsEvent{
  final int driverPhone;
  DriverPhoneChnages(this.driverPhone);
 }
  final class DriverEmailChnages extends AddDriverDetailsEvent{
  final String driverEmail;
  DriverEmailChnages(this.driverEmail);
 }
  final class DriverLicenseImageChnages extends AddDriverDetailsEvent{
  final String driverLicenseImg;
  DriverLicenseImageChnages(this.driverLicenseImg);
 }
   final class DriverDobChnages extends AddDriverDetailsEvent{
  final String driverDob;
  DriverDobChnages(this.driverDob);
 }
   final class DriverId extends AddDriverDetailsEvent{
  final String driverId;
  DriverId(this.driverId);
 }
    final class DriverFormSubmit extends AddDriverDetailsEvent{

 }
 