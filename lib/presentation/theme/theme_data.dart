import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

import 'theme_color.dart';

ThemeData get appTheme {
  return ThemeData(
    fontFamily: 'GoogleSF',
    primaryColor: AppColors.primary,
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radius_12),
      ),
    ),
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(color: AppColors.background, elevation: 0.0),
    toggleableActiveColor: AppColors.primary,
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: AppColors.primary),
    cupertinoOverrideTheme: CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
        dateTimePickerTextStyle: TextStyle(
          color: AppColors.blue900,
          fontSize: 22.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}
