import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

void warningDialog({
  required BuildContext context,
  // required bool isSynch,
  String? name,
  required Function() btnOk,
  required Function() btnCancel,
}) {
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
              //   style: ThemeText.bodySemibold.copyWith(
              //       fontSize: MainScreenConstants.synchronizedSize),
              // ),
              RichText(
                text: TextSpan(
                    text: 'Bạn có muốn',
                    style: ThemeText.bodySemibold.copyWith(
                      color: AppColors.black54,
                      fontSize: 16.sp,
                    ),
                    children: [
                      TextSpan(
                        text: name == null ? ' đăng xuất' : ' xoá',
                        style: ThemeText.bodySemibold.copyWith(
                          color: AppColors.errorColor,
                          fontSize: 16.sp,
                        ),
                      ),
                      TextSpan(
                        text: '?',
                        style: ThemeText.bodySemibold.copyWith(
                          color: AppColors.black54,
                          fontWeight: FontWeight.normal,
                          fontSize: 16.sp,
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: 8,
              ),
              name == null
                  ? Text(
                      'Các ghi chú đã tạo và điểm được thêm vào sẽ bị mất khi đăng xuất.',
                      style: ThemeText.bodySemibold.copyWith(
                        color: AppColors.black54,
                        fontSize: 14.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    )
                  : Text(
                      name,
                      style: ThemeText.bodySemibold.copyWith(
                        color: AppColors.black54,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    )
            ],
          )),
      btnOk: GestureDetector(
        onTap: () => btnOk(),
        child: Container(
          margin: EdgeInsets.only(bottom: 16.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.blue500,
            boxShadow: [
              BoxShadow(
                color: AppColors.charade.withOpacity(0.3),
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
              style: ThemeText.bodySemibold.s16.bianca,
            ),
          ),
        ),
      ),
      btnCancel: GestureDetector(
        onTap: () => btnCancel(),
        child: Container(
          margin: EdgeInsets.only(bottom: 16.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.errorColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.charade.withOpacity(0.3),
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
              'Huỷ',
              style: ThemeText.bodySemibold.s16.bianca,
            ),
          ),
        ),
      )).show();
}
