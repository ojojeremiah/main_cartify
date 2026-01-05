import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:main_cartify/l10n/app_localizations.dart';
import 'package:main_cartify/modules/startup/features/splashscreen/presentation/screens/splashscreen.dart';
import 'package:main_cartify/presentation/presentation_logic/dependency_injector.dart';
import 'package:main_cartify/presentation/presentation_logic/provider/products.dart';
import 'package:main_cartify/utils/app_theme.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  await dependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => getIt<ProductNotifier>()),
          ],
          child: Builder(
            builder: (context) {
              // ✅ Set system UI style (light mode)
              SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle(
                  statusBarColor: Theme.of(context).hintColor,
                  statusBarBrightness: Brightness.light,
                ),
              );

              return OverlaySupport.global(
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Cartify',
                  theme: AppThemes.appLightTheme,

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
          ),
        );
      },
    );
  }
}
