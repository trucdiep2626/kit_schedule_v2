import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';

import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/text_field_widget.dart';

void updateScheduleDialog(
    {required BuildContext context,
    String? name,
    Key? key,
    bool keepOldSchedule = false,
    required Function(String) btnOk,
    required Function() btnCancel,
    required Function(bool) onChanged}) {
  final passwordController = TextEditingController();

  bool isShowPassword = false;
  AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 8.sp),
          child: Column(
            children: [
              Text(
                'Cập nhật lịch học',
                style: ThemeText.bodySemibold.copyWith(
                  color: AppColors.black54,
                  fontSize: 16.sp,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              name == null
                  ? Text(
                      'Nhập mật khẩu để cập nhật lịch học mới nhất',
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
                    ),
              SizedBox(
                height: 25.h,
              ),
              Form(
                key: key,
                child: Column(
                  children: [
                    StatefulBuilder(
                      builder: (context, setState) => TextFieldWidget(
                        hintText: 'Mật khẩu',
                        controller: passwordController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Vui lòng nhập mật khẩu';
                          }
                          return null;
                        },
                        onSubmitted: (p0) {
                          passwordController.text = p0;
                        },
                        obscureText: !isShowPassword,
                        seffixIcon: IconButton(
                          icon: Icon(
                            isShowPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.blue500,
                          ),
                          onPressed: () {
                            setState(() {
                              isShowPassword = !isShowPassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  StatefulBuilder(
                    builder: (context, setState) => Checkbox(
                      activeColor: AppColors.grey300,
                      checkColor: AppColors.blue500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      value: keepOldSchedule,
                      onChanged: (value) {
                        setState(() {
                          keepOldSchedule = value!;
                        });
                        onChanged(keepOldSchedule);
                      },
                    ),
                  ),
                  Text(
                    'Xóa lịch học cũ',
                    style: ThemeText.bodySemibold.copyWith(
                      color: AppColors.black54,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              // tại sao tôi phải nhập mật khẩu
              // nút điều huonwegs tới phần diều khoản
            ],
          )),
      btnOk: GestureDetector(
        onTap: () => btnOk(passwordController.text),
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
