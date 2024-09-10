part of 'add_driver_details_bloc.dart';
enum DriverUploadStatus{inital,pending,sucess,failure}
 class AddDriverDetailsState{
  AddDriverDetailsState({
     this.id='',
     this.driverDob='',
     this.driverEmail='',
     this.driverImg='',
     this.driverLicenseImg='',
     this.driverName='',
     this.driverPhone=0,
     this.status=DriverUploadStatus.inital
  });
 final String? id;
 final String? driverName;
 final DriverUploadStatus status;
 final int? driverPhone;
final  String? driverDob;
 final String? driverEmail;
 final String? driverLicenseImg;
 final String? driverImg;
 AddDriverDetailsState copyWith({
  final String? id,
 final String? driverName,
 final DriverUploadStatus? status,
 final int? driverPhone,
 final  String? driverDob,
 final String? driverEmail,
 final String? driverLicenseImg,
 final String? driverImg,
 })=>AddDriverDetailsState(
id: id??this.id,
driverName: driverName??this.driverName,
status: status??this.status,
driverDob: driverDob??this.driverDob,
driverPhone: driverPhone??this.driverPhone,
driverEmail: driverEmail??this.driverEmail,
driverImg: driverImg??this.driverImg,
driverLicenseImg: driverLicenseImg??this.driverLicenseImg,

 );
}