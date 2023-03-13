import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/config/database/hive_config.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/personal/personal_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/setting/setting_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/setting/setting_page.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/donate_dialog.dart';
import 'package:kit_schedule_v2/presentation/widgets/export.dart';

import 'package:kit_schedule_v2/presentation/widgets/app_dialog.dart';
import 'package:kit_schedule_v2/presentation/widgets/text_field_widget.dart';
import 'package:kit_schedule_v2/presentation/widgets/warning_dialog.dart';

import 'package:url_launcher/url_launcher_string.dart';
import 'package:store_redirect/store_redirect.dart';

class PersonalPage extends GetView<PersonalController> {
  final MainController _mainController = Get.find<MainController>();

  PersonalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return controller.rxPersonalLoadedType.value == LoadedType.start
        ? const Center(
            child: CupertinoActivityIndicator(),
          )
        : Scaffold(
            backgroundColor: AppColors.bianca,
            body: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                            top: Get.mediaQuery.padding.top + 20.sp,
                          ),
                          padding: EdgeInsets.all(16.sp),
                          decoration: const BoxDecoration(
                            color: AppColors.blue100,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person,
                            color: AppColors.blue900,
                            size: 32.sp,
                          )),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.sp),
                          child: Column(
                            children: [
                              Text(
                                _mainController.studentInfo.value.displayName ??
                                    '',
                                textAlign: TextAlign.center,
                                style: ThemeText.bodySemibold.s20.blue900,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                _mainController.studentInfo.value.studentCode ??
                                    '',
                                textAlign: TextAlign.center,
                                style: ThemeText.bodyRegular.s16,
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                _buildListTile(
                    icon: Icons.score_outlined,
                    onTap: () async => await _mainController.onChangedNav(1),
                    title: 'Điểm của tôi'),
                _buildListTile(
                  icon: Icons.system_update_outlined,
                  onTap: () {
                    actionUpdateSchedule(context);
                  },
                  title: 'Cập nhật lịch học',
                ),
                _buildListTile(
                  onTap: () {
                    Get.toNamed(AppRoutes.donate);
                    donateDialog(context);
                  },
                  title: 'Ủng hộ',
                  icon: Icons.monetization_on_outlined,
                ),
                _buildListTile(
                  icon: Icons.settings_outlined,
                  onTap: () {
                    Get.to(() => const SettingPage());
                  },
                  title: 'Cài đặt',
                ),
                _buildListTile(
                  icon: Icons.info_outline,
                  onTap: _launchURLKitClub,
                  title: 'Về chúng tôi',
                ),
                _buildListTile(
                  icon: Icons.star_rate_outlined,
                  onTap: _launchURLChPlay,
                  title: 'Đánh giá',
                ),
                _buildListTile(
                  icon: Icons.logout,
                  onTap: () {
                    controller.clearDataScore();
                    actionLogIn(
                      context,
                    );
                  },
                  title: 'Đăng xuất',
                ),
              ],
            ),
          );
  }

  void actionUpdateSchedule(BuildContext context) {
    updateScheduleDialog(
      key: controller.formKey,
      btnOk: () {
        controller.updateSchedule();
      },
      btnCancel: () => Get.back(),
    );
  }

  void actionLogIn(
    BuildContext context,
  ) {
    warningDialog(
        context: context,
        btnOk: controller.logOut,
        btnCancel: () => Get.back());
  }

  bool isEnglish(String isEng) {
    if (isEng == 'vi') {
      return false;
    }
    return true;
  }

  Widget _buildListTile(
      {required Function()? onTap,
      required String title,
      required IconData icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.sp),
        color: AppColors.bianca,
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.blue900,
              size: 20.sp,
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              title,
              style: ThemeText.bodyMedium.blue900,
            ),
          ],
        ),
      ),
    );
  }

  Widget _dialogItem(
      {required String title,
      required BuildContext context,
      //  required bool isLanguageDialog,
      required Function()? onTap,
      required bool visible}) {
    return GestureDetector(
        onTap: onTap,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.all(16.sp),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: ThemeText.bodyMedium.blue900,
                    ),
                  ),
                ),
                Visibility(
                    visible: visible,
                    child: const Icon(
                      Icons.check,
                      color: AppColors.blue900,
                    ))
              ],
            ),
          ),
          Container(
              height: 0.2,
              width: MediaQuery.of(context).size.width - 50,
              color: AppColors.grey400),
        ]));
  }

  void updateScheduleDialog({
    String? name,
    Key? key,
    required Function() btnOk,
    required Function() btnCancel,
  }) {
    AwesomeDialog(
        dismissOnTouchOutside: false,
        context: controller.context,
        dialogType: DialogType.info,
        animType: AnimType.bottomSlide,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 8.sp),
          child: Obx(
            () => controller.rxLoadedType.value == LoadedType.start
                ? SizedBox(
                    height: 200.sp,
                    child: const Center(
                      child: CupertinoActivityIndicator(
                        radius: 25,
                      ),
                    ),
                  )
                : Column(
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
                        key: controller.formKey,
                        child: TextFieldWidget(
                          hintText: 'Mật khẩu',
                          controller: controller.passwordController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Vui lòng nhập mật khẩu';
                            }
                            return null;
                          },
                          onSubmitted: (p0) {
                            controller.passwordController.text = p0;
                          },
                          obscureText: !controller.isShowPassword.value,
                          seffixIcon: IconButton(
                            icon: Icon(
                              controller.isShowPassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.blue500,
                            ),
                            onPressed: () {
                              controller.isShowPassword.value =
                                  !controller.isShowPassword.value;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          Obx(
                            () => Checkbox(
                              activeColor: AppColors.grey300,
                              checkColor: AppColors.blue500,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              value: controller.keepOldSchedule.value,
                              onChanged: (value) {
                                controller.keepOldSchedule.value = value!;
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
                    ],
                  ),
          ),
        ),
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

  _launchURLKitClub() async {
    const facebookAppUrl = "fb://page/384011765537773";
    const facebookWebUrl = 'https://www.facebook.com/kitclubKMA';
    if (await canLaunchUrlString(facebookAppUrl)) {
      await launchUrlString(facebookAppUrl);
    } else {
      await launchUrlString(facebookWebUrl);
    }
  }

  _launchURLChPlay() async {
    StoreRedirect.redirect(
      androidAppId: "kma.hatuan314.schedule",
    );
  }
}
