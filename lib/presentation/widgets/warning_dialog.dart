import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

void warningDialog(
    {required BuildContext context,
    // required bool isSynch,
    String? name,
    required Function(BuildContext) btnOk,
    required Function(BuildContext) btnCancel}) {
  AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.sp, horizontal: 8.sp),
          child: Column(
            children: [
              // isSynch
              //     ? SizedBox()
              //     : Text(
              //   AppLocalizations.of(context)!.synchronizedTxt,
              //   style: ThemeText.titleStyle.copyWith(
              //       fontSize: MainScreenConstants.synchronizedSize),
              // ),
              RichText(
                text: TextSpan(
                    text: 'Bạn có muốn',
                    style: ThemeText.titleStyle.copyWith(
                      color: AppColors.thirdColor,
                      fontSize: 16.sp,
                    ),
                    children: [
                      TextSpan(
                        text: name == null ? ' đăng xuất' : ' xoá',
                        style: ThemeText.titleStyle.copyWith(
                          color: AppColors.errorColor,
                          fontSize: 16.sp,
                        ),
                      ),
                      TextSpan(
                        text: '?',
                        style: ThemeText.titleStyle.copyWith(
                          color: AppColors.thirdColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 16.sp,
                        ),
                      ),
                    ]),
              ),
              name == null
                  ? const SizedBox()
                  : Text(
                      name,
                      style: ThemeText.titleStyle.copyWith(
                        color: AppColors.thirdColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    )
            ],
          )),
      btnOk: GestureDetector(
        onTap: () => btnOk(context),
        child: Container(
          margin: EdgeInsets.only(bottom: 16.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.fourthColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(
                  0,
                  3,
                ),
              )
            ],
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 16.sp),
            child: Text(
              'Đồng ý',
              style: ThemeText.buttonLabelStyle.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.secondColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      btnCancel: GestureDetector(
        onTap: () => btnCancel(context),
        child: Container(
          margin: EdgeInsets.only(bottom: 16.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.errorColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(
                  0,
                  3,
                ),
              )
            ],
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 16.sp),
            child: Text('Huỷ',
                style: ThemeText.buttonLabelStyle.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.secondColor,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      )).show();
}
