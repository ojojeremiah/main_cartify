import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:main_cartify/modules/startup/features/splashscreen/presentation/screens/splashscreen.dart';
import 'package:main_cartify/utils/app_theme.dart';
import 'package:overlay_support/overlay_support.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return OverlaySupport.global(
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: "Cartify",
                  // themeMode: themeProvider.themeMode,
                  theme: AppThemes.appLightTheme,
                  // darkTheme: AppThemes.appDarkTheme,
                  home: const SplashScreen(),
                ),
              );
      },
    );
  }
}
