import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

class ThemeBorder {
  static const BorderRadius borderRadiusAll =
      BorderRadius.all(Radius.circular(12));
  static OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
    borderRadius: borderRadiusAll,
    borderSide: BorderSide(color: AppColors.charade),
  );


  static double borderWidth = 5.w;

  static BorderSide scheduleElementBorder = BorderSide(
      width: ScreenUtil().setWidth(1.2),
      color: AppColors.blue800);

  static BorderSide textFieldEnableBorder =
      BorderSide(color: AppColors.borderColor, width: ScreenUtil().setWidth(1.2));

  static BorderSide textFieldErrorBorder =
      BorderSide(color: AppColors.errorColor, width: ScreenUtil().setWidth(3));
  static OutlineInputBorder textFieldBorder = OutlineInputBorder(
      borderSide: BorderSide(
          color: AppColors.errorColor, width: ScreenUtil().setWidth(3)),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)));

  // static OutlineInputBorder textFieldBorder = OutlineInputBorder(
  //     borderSide: BorderSide(color: Colors.black, width: 1.0),
  //     borderRadius: BorderRadius.all(Radius.circular(8.0)));
  //
  // static BoxDecoration containerBorder = BoxDecoration(
  //     border: Border.all(color: Colors.black, width: 1.0),
  //     borderRadius: BorderRadius.all(Radius.circular(8.0)));
}
