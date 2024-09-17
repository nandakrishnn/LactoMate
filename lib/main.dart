
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lactomate/firebase_options.dart';
import 'package:lactomate/services/driver_service.dart';
import 'package:lactomate/services/shop_service.dart';
import 'package:lactomate/views/admin/drivers/add_drivers_bloc/add_driver_details_bloc.dart';
import 'package:lactomate/views/admin/drivers/get_diriver_home/get_cart_details_user_bloc.dart';
import 'package:lactomate/views/admin/shops/bloc_add_shop/shop_details_addition_bloc.dart';
import 'package:lactomate/views/admin/shops/bloc_get_shop/get_shop_details_bloc.dart';
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
       BlocProvider(
        create: (context) => GetWorkerDetailsUserBloc(DriverService()),
    
       ),
       BlocProvider(
        create: (context) => ShopDetailsAdditionBloc(ShopService()),
       ),
       BlocProvider(
        create: (context) => GetShopDetailsBloc(ShopService()),
       )
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