
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lactomate/firebase_options.dart';
import 'package:lactomate/services/driver_service.dart';
import 'package:lactomate/views/admin/drivers/add_drivers_bloc/add_driver_details_bloc.dart';
import 'package:lactomate/views/user_login.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override 
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddDriverDetailsBloc(DriverService()),
        ),
       
      ],
      
    
      child: ScreenUtilInit(
            designSize: Size(360, 690),
        child:  MaterialApp(
          debugShowCheckedModeBanner: false,
          home: WorkerLoginPage(),
        ),
      ),
    );
  }
}