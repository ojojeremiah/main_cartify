import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_cartify/utils/app_colors.dart';

class AppThemes {
  /// ✅ Light Theme
  static final ThemeData appLightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.lightScaffoldColor,
    canvasColor: AppColors.lightScaffoldColor,
    cardColor: AppColors.lightCardColor,
    dividerColor: AppColors.lightSplashColor,
    splashColor: AppColors.lightSplashColor,
    highlightColor: AppColors.lightSplashColor,
    disabledColor: AppColors.lightSplashColor,
    dialogBackgroundColor: AppColors.whiteColor,
    indicatorColor: AppColors.primaryColor,
    hintColor: AppColors.lightThemeTextColor,

    /// ✅ Text Theme
    textTheme: GoogleFonts.poppinsTextTheme(
      TextTheme(
        displayLarge: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 34.sp,
          fontWeight: FontWeight.w600,
        ),
        displayMedium: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: AppColors.lightThemeTextColor,
          fontSize: 15.sp,
        ),
        titleSmall: TextStyle(
          color: AppColors.lightThemeTextColor,
          fontSize: 15.sp,
        ),
        bodyLarge: TextStyle(
          color: AppColors.lightThemeTextColor,
          fontSize: 14.sp,
        ),
      ),
    ),

    /// ✅ Primary Text Theme
    primaryTextTheme: GoogleFonts.poppinsTextTheme(
      TextTheme(
        headlineSmall: TextStyle(
          color: AppColors.blackColor,
          fontSize: 18.sp,
        ),
        titleMedium: TextStyle(
          color: AppColors.blackColor,
          fontSize: 15.sp,
        ),
        titleSmall: TextStyle(
          color: AppColors.blackColor,
          fontSize: 15.sp,
        ),
        bodyLarge: TextStyle(
          color: AppColors.blackColor,
          fontSize: 14.sp,
        ),
      ),
    ),

    /// ✅ Icons
    iconTheme: IconThemeData(
      color: AppColors.lightThemeTextColor,
      size: 30.sp,
    ),
    primaryIconTheme: IconThemeData(
      color: AppColors.lightThemeTextColor,
      size: 20.sp,
    ),

    /// ✅ TabBar
    tabBarTheme: const TabBarThemeData(
  indicatorSize: TabBarIndicatorSize.tab,
  labelColor: AppColors.lightThemeTextColor,
  unselectedLabelColor: AppColors.lightSplashColor,
),


    /// ✅ Checkbox / Radio / Switch
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) return AppColors.primaryColor;
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) return AppColors.primaryColor;
        return null;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) return AppColors.primaryColor;
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) return AppColors.primaryColor.withOpacity(0.5);
        return null;
      }),
    ),

    bottomAppBarTheme: const BottomAppBarTheme(color: AppColors.lightCardColor),

    /// ✅ Color Scheme
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(
      background: AppColors.primaryColor,
      error: AppColors.errorColor,
    ),
  );

  /// ✅ Dark Theme
  static final ThemeData appDarkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.darkScaffoldColor,
    canvasColor: AppColors.darkScaffoldColor,
    cardColor: AppColors.darkScaffoldColor,
    dividerColor: AppColors.darkSplashColor,
    splashColor: AppColors.darkSplashColor,
    highlightColor: AppColors.darkSplashColor,
    disabledColor: AppColors.darkSplashColor,
    dialogBackgroundColor: AppColors.darkScaffoldColor,
    indicatorColor: AppColors.primaryColor,
    hintColor: AppColors.darkThemeTextColor,

    /// ✅ Text Theme
    textTheme: GoogleFonts.poppinsTextTheme(
      TextTheme(
        headlineSmall: TextStyle(
          color: AppColors.darkThemeTextColor,
          fontSize: 18.sp,
        ),
        titleMedium: TextStyle(
          color: AppColors.darkThemeTextColor,
          fontSize: 15.sp,
        ),
        titleSmall: TextStyle(
          color: AppColors.darkThemeTextColor,
          fontSize: 15.sp,
        ),
        bodyLarge: TextStyle(
          color: AppColors.darkThemeTextColor,
          fontSize: 14.sp,
        ),
        bodyMedium: TextStyle(
          color: AppColors.darkThemeTextColor,
          fontSize: 14.sp,
        ),
        bodySmall: TextStyle(
          color: AppColors.darkThemeTextColor,
          fontSize: 13.sp,
        ),
      ),
    ),

    /// ✅ Primary Text Theme
    primaryTextTheme: GoogleFonts.poppinsTextTheme(
      TextTheme(
        headlineSmall: TextStyle(
          color: AppColors.darkThemeTextColor,
          fontSize: 18.sp,
        ),
        titleMedium: TextStyle(
          color: AppColors.darkThemeTextColor,
          fontSize: 15.sp,
        ),
        titleSmall: TextStyle(
          color: AppColors.darkThemeTextColor,
          fontSize: 15.sp,
        ),
        bodyLarge: TextStyle(
          color: AppColors.darkThemeTextColor,
          fontSize: 14.sp,
        ),
      ),
    ),

    /// ✅ Icons
    iconTheme: IconThemeData(
      color: AppColors.primaryColor,
      size: 30.sp,
    ),
    primaryIconTheme: IconThemeData(
      color: AppColors.primaryColor,
      size: 30.sp,
    ),

    /// ✅ TabBar
    tabBarTheme: const TabBarThemeData(
  indicatorSize: TabBarIndicatorSize.tab,
  labelColor: AppColors.whiteColor,
  unselectedLabelColor: AppColors.darkSplashColor,
),


    /// ✅ Checkbox / Radio / Switch
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) return AppColors.primaryColor;
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) return AppColors.primaryColor;
        return null;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) return AppColors.primaryColor;
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) return AppColors.primaryColor.withOpacity(0.5);
        return null;
      }),
    ),

    bottomAppBarTheme: const BottomAppBarTheme(color: AppColors.darkCardColor),

    /// ✅ Color Scheme
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.grey,
    ).copyWith(
      background: AppColors.primaryColor,
      error: AppColors.errorColor,
    ),
  );
}
