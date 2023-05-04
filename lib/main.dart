// test git error
import 'package:albaraka/src/core/local/shared_prefrences.dart';
import 'package:albaraka/src/core/services/dep_injection.dart';
import 'package:albaraka/src/modules/authenticaion/presentation_layer/bloc/auth_bloc.dart';
import 'package:albaraka/src/modules/authenticaion/presentation_layer/screens/login.dart';
import 'package:albaraka/src/modules/delivery/presentation_layer/bloc/order_bloc.dart';
import 'package:albaraka/src/modules/main/presentation_layer/screens/main_screen.dart';
import 'package:albaraka/src/modules/menu/presentation_layer/bloc/menu_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'src/core/services/constants.dart';
import 'src/modules/main/presentation_layer/bloc/main_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  await  Firebase.initializeApp();
  await  CacheHelper.init();
  Widget? widget;

  uId = await CacheHelper.getData(key: 'uid');
  if (uId != null) {
    widget = MainScreen();
  } else {
    widget = const LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}
class MyApp extends StatelessWidget
{
  final Widget? startWidget;
  const MyApp({super.key, this.startWidget});
  @override
  Widget build(BuildContext context)
  {
    return Sizer(builder: (context , orientaion , deviceType){
      return MultiBlocProvider(
        providers: [
          BlocProvider<MainBloc>(
            create: (BuildContext context) => MainBloc(MainInitial()),
          ),
          BlocProvider<MenuBloc>(
            create: (BuildContext context) => MenuBloc(MenuInitial()),
          ),
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => AuthBloc(AuthInitial()),
          ),
          BlocProvider<OrderBloc>(
            create: (BuildContext context) => OrderBloc(OrderInitial()),
          ),
        ],
        child: MaterialApp (
          debugShowCheckedModeBanner: false,
          title: 'الزبائن',
          theme: ThemeData(
            primarySwatch: Colors.blue,),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar', 'AE'), // English, no country code
          ],
          home: startWidget,
        ),
      ) ;
    });
  }
}