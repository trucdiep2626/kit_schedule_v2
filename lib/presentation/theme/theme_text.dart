import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/common/common_export.dart';

import 'theme_color.dart';

class ThemeText {
  static TextStyle headline1 = TextStyle(
    fontSize: 96.sp,
    color: AppColors.text,
    fontWeight: FontWeight.w300,
  );

  static TextStyle headline2 = TextStyle(
    fontSize: 60.sp,
    color: AppColors.text,
    fontWeight: FontWeight.w300,
  );

  static TextStyle headline3 = TextStyle(
    fontSize: 48.sp,
    color: AppColors.text,
    fontWeight: FontWeight.normal,
  );

  static TextStyle headline4 = TextStyle(
    fontSize: 34.sp,
    color: AppColors.text,
    fontWeight: FontWeight.normal,
  );

  static TextStyle headline5 = TextStyle(
    fontSize: 24.sp,
    color: AppColors.text,
    fontWeight: FontWeight.normal,
  );

  static TextStyle headline6 = TextStyle(
    fontSize: 20.sp,
    color: AppColors.text,
    fontWeight: FontWeight.w500,
  );

  static TextStyle subtitle1 = TextStyle(
    fontSize: 16.sp,
    color: AppColors.text,
    fontWeight: FontWeight.w500,
  );

  static TextStyle subtitle2 = TextStyle(
    fontSize: 14.sp,
    color: AppColors.text,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bodyText1 = TextStyle(
    fontSize: 16.sp,
    color: AppColors.text,
    fontWeight: FontWeight.normal,
  );

  static TextStyle bodyText2 = TextStyle(
    fontSize: 13.sp,
    color: AppColors.text,
    fontWeight: FontWeight.normal,
  );

  static TextStyle button = TextStyle(
    fontSize: 14.sp,
    color: AppColors.text,
    fontWeight: FontWeight.w500,
  );

  static TextStyle caption = TextStyle(
    fontSize: 12.sp,
    color: AppColors.text,
    fontWeight: FontWeight.normal,
  );

  static TextStyle overline = TextStyle(
    fontSize: 10.sp,
    color: AppColors.text,
    fontWeight: FontWeight.normal,
  );


  static TextStyle buttonStyle = TextStyle(
      color: AppColors.secondColor,
      fontSize: ScreenUtil().setSp(18),
      fontWeight: FontWeight.w500);

  static TextStyle textStyle = TextStyle(
      color: AppColors.primaryColor,
      fontSize: ScreenUtil().setSp(14),
      fontWeight: FontWeight.w500);

  static TextStyle titleStyle = TextStyle(
      fontSize: ScreenUtil().setSp(22),
      color: AppColors.personalScheduleColor,
      fontFamily: 'MR',
      fontWeight: FontWeight.w600);

  static TextStyle titleStyle2 = TextStyle(
      fontSize: ScreenUtil().setSp(20),
      color: AppColors.personalScheduleColor,
      fontFamily: 'MR',
      fontWeight: FontWeight.w600);

  static TextStyle errorTextStyle = TextStyle(
      fontSize: ScreenUtil().setSp(14),
      color: AppColors.errorColor2,
      fontFamily: "MR");

  static TextStyle numberStyle = TextStyle(
      fontSize: ScreenUtil().setSp(14),
      color: AppColors.secondColor,
      fontWeight: FontWeight.normal);

  static TextStyle headerStyle = TextStyle(
      fontSize: ScreenUtil().setSp(25),
      color: AppColors.secondColor,
      fontFamily: 'MR',
      fontWeight: FontWeight.w600);

  static TextStyle headerStyle2 = TextStyle(
      fontSize: ScreenUtil().setSp(25),
      color: AppColors.signInColor,
      fontFamily: 'MR',
      fontWeight: FontWeight.w600);

  static TextStyle textInforStyle = TextStyle(
      fontFamily: 'MR',
      color: AppColors.secondColor,
      fontSize: ScreenUtil().setSp(18),
      fontWeight: FontWeight.normal);

  static TextStyle labelStyle = TextStyle(
      fontSize: ScreenUtil().setSp(18),
      color: AppColors.personalScheduleColor,
      fontWeight: FontWeight.w500,
      fontFamily: "MR");

  static TextStyle buttonLabelStyle = TextStyle(
      color: Color(0xffFCFAF3),
      fontSize: ScreenUtil().setSp(18),
      fontFamily: 'MR',
      fontWeight: FontWeight.w600);

  static TextStyle dayOfWeekStyle =
  TextStyle(fontFamily: 'MR', fontWeight: FontWeight.w400);

  /*static TextStyle errorTextStyle = TextStyle(
      color: AppColors.errorColor,
      fontSize: ScreenUtil().setSp(24),
      fontWeight: FontWeight.w500);

  static TextStyle menuItemTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
    //  fontSize: HomeScreenConstance.menuItemTextSize,
      color: AppColors.menuItemTextColor);
  static TextStyle accountTextStyle = TextStyle(
      fontWeight: FontWeight.normal,
   //   fontSize: HomeScreenConstance.menuItemTextSize,
      color: Colors.white);
  static TextStyle dayOfWeekStyle = TextStyle(
      fontWeight: FontWeight.normal,
     // fontSize: HomeScreenConstance.dayOfWeekTextSize,
      color: Colors.red);
*/
  TextStyle welcomeTextStyle = TextStyle(
      letterSpacing: 5.w,
      fontSize: 20.sp,
//        fontWeight: FontWeight.w300,
      fontFamily: 'MR',
      color: AppColors.signInColor);

  static TextTheme getDefaultTextTheme = TextTheme(
    // headline3: TextStyle(
    //     fontSize: 50.sp,
    //     fontWeight: FontWeight.w900,
    //     color: AppColors.white),
    // headline2: TextStyle(
    //     fontSize: 60.sp,
    //     fontWeight: FontWeight.w900,
    //     color: AppColors.white),
    // headline5: TextStyle(
    //     fontSize: 22.sp,
    //     fontWeight: FontWeight.w900,
    //     color: AppColors.white),
    // subtitle1: TextStyle(
    //     fontSize: 18.sp,
    //     fontWeight: FontWeight.normal,
    //     color: AppColors.white),
    // bodyText1: TextStyle(
    //     fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.navy),
    // bodyText2: TextStyle(
    //     fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.navy),
    button: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.primaryColor),
    // caption: TextStyle(
    //     fontSize: 12.sp,
    //     fontWeight: FontWeight.normal,
    //     color: AppColors.grey),
  );
}
