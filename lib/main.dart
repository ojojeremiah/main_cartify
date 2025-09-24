import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:main_cartify/l10n/app_localizations.dart';
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
            title: 'Cartify',
            theme: AppThemes.appLightTheme,
            // darkTheme: AppThemes.appDarkTheme,
            // themeMode: themeProvider.themeMode,

            // ✅ Localization setup
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English
              Locale('es'), // Spanish
            ],

            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
