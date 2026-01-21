import 'package:flutter/material.dart';
import 'package:main_cartify/dimension/dimension.dart';
import 'package:main_cartify/utils/app_colors.dart';

class AppTextstyles {
  static TextStyle xsmallSize = TextStyle(
    fontSize: Dimension.xsmallSize,
    fontWeight: FontWeight.bold,
  );

  static TextStyle appBarText = TextStyle(
    color: AppColors.blackColor,
    fontSize: Dimension.xmsmallSize,
    fontWeight: FontWeight.bold,
  );

  static TextStyle colorgrey = TextStyle(
    color: Colors.grey[500],
    fontWeight: FontWeight.bold,
  );

  static TextStyle xsmallSizelight = TextStyle(
    fontSize: Dimension.xsmallSize,
    color: AppColors.lightCardColor,
  );
}
