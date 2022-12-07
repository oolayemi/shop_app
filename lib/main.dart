import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shop_app/views/splash_screen/splash_screen.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/locator.dart';
import 'app/router.dart';
import 'core/constants/setup_dialog.dart';
import 'core/managers/life_cycle_manager.dart';
import 'core/utils/logger.dart';
import 'widgets/utility_widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  Platform.isAndroid
      ? SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, statusBarBrightness: Brightness.light, statusBarIconBrightness: Brightness.light))
      : SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, statusBarBrightness: Brightness.light, statusBarIconBrightness: Brightness.light));

  await dotenv.load(fileName: ".env");
  await setupLocator();

  setupLogger();
  setupDialog();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LifeCycleManager(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sample',
          onGenerateRoute: Routers().onGenerateRoute,
          navigatorKey: locator<NavigationService>().navigatorKey,
          theme: ThemeData(
            primaryColor: Colors.blue,
            canvasColor: Colors.white,
            primarySwatch: createMaterialColor(Colors.blue),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: TextTheme(
                headline3: const TextStyle().copyWith(
                  color: Colors.black,
                ),
                headline4: const TextStyle().copyWith(
                  color: Colors.black,
                ),
                headline5: const TextStyle().copyWith(
                  color: Colors.black,
                ),
                headline6: const TextStyle().copyWith(color: Colors.black, fontWeight: FontWeight.w700)),
          ),
          home: const SplashScreen()),
    );
  }
}