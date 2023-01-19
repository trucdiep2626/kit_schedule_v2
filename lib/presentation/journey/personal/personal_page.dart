import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';
// import 'package:kit_schedule_v2/presentation/journey/demo_widget.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/personal/personal_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/warning_dialog.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../demo_widget.dart';

class PersonalPage extends GetView<PersonalController> {
  final MainController _mainController = Get.find<MainController>();

  PersonalPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          _mainController.studentInfo.value.displayName ?? '',
                          textAlign: TextAlign.center,
                          style: ThemeText.bodySemibold.s20.blue900,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          _mainController.studentInfo.value.studentCode ?? '',
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
          // _buildListTile(
          //     icon: Icons.language,
          //     onTap: () {
          //       showDialog(
          //           context: context,
          //           builder: (dialogContext) =>
          //               settingDialog(context, true, profileState));
          //     },
          //     title: ''),
          _buildListTile(
            icon: Icons.notifications_none,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (dialogContext) => settingDialog(context));
            },
            title: 'Cài đặt thông báo',
          ),
          _buildListTile(
            icon: Icons.info_outline,
            onTap: _launchURL,
            title: 'Về chúng tôi',
          ),
          _buildListTile(
            icon: Icons.star_rate_outlined,
            onTap: _launchURL,
            //() {
            // StoreRedirect.redirect(
            //   androidAppId: ProfileConstants.androidAppId,
            // );
            //key: 'kma.hatuan314.schedule'
            // },
            title: 'Đánh giá',
          ),
          _buildListTile(
            icon:
                //profileState.isLogIn ?
                Icons.logout,
            //: Icons.login,
            onTap: () {
              actionLogIn(
                context,
              );
            },
            title: 'Đăng xuất',
          ),
          _buildListTile(onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder:
              (context) {
              return const DemoWidget();
            }));
          }, title: "Widgets", icon: Icons.widgets)
          // if (profileState.isLogIn)
          //   _buildListTile(
          //     onTap: () => _actionDeleteAccount(context),
          //     title: AppLocalizations.of(context)!.deleteAccount,
          //     icon: Icons.no_accounts_rounded,
          //   )
        ],
      ),
    );
  }

  // void _actionDeleteAccount(BuildContext context) {
  //   warningDialog(
  //     context: context,
  //     isSynch: true,
  //     name: AppLocalizations.of(context)!.deleteAccount,
  //     btnCancel: (context) => Navigator.pop(context),
  //     btnOk: (context) {
  //       BlocProvider.of<HomeBloc>(context)..add(DeleteAccountEvent());
  //       Navigator.of(context).pop();
  //     },
  //   );
  // }

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

  Widget settingDialog(
    BuildContext context,
  ) {
    return SimpleDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.symmetric(
        vertical: 12.sp,
        horizontal: 16.sp,
      ),
      title: Container(
        padding: EdgeInsets.all(16.sp),
        width: MediaQuery.of(context).size.width,
        color: AppColors.blue900,
        child: Text(
          'Cài đặt thông báo',
          style: ThemeText.bodySemibold
              .copyWith(color: AppColors.bianca, fontSize: 18.sp),
        ),
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dialogItem(
              title: 'Bật thông báo',
              context: context,
              onTap: () {},
              // isLanguageDialog
              //     ? () {
              //   Injector.getIt<LanguageSelect>().changeLanguage(true);
              // }
              //     : !profileState.hasNoti
              //     ? () async {
              //   if (await Permission.calendar.isDenied) {
              //     Navigator.pop(context);
              //     openSettingDiaLog(
              //       context: context,
              //     );
              //     return;
              //   } else {
              //     BlocProvider.of<ProfileBloc>(context)
              //         .add(TurnOnNotificationEvent());
              //     Navigator.pop(context);
              //     BlocProvider.of<ProfileBloc>(context)
              //         .add(GetUserNameInProfileEvent());
              //   }
              // }
              //     : () {},
              visible: false,
            ),
            _dialogItem(
              title: 'Tắt thông báo',
              context: context,
              onTap:
                  // isLanguageDialog
                  //     ? () {
                  //   Injector.getIt<LanguageSelect>().changeLanguage(false);
                  // }
                  //     : profileState.hasNoti
                  //     ? () {
                  //   BlocProvider.of<ProfileBloc>(context)
                  //       .add(TurnOffNotificationEvent());
                  //   Navigator.pop(context);
                  //   BlocProvider.of<ProfileBloc>(context)
                  //       .add(GetUserNameInProfileEvent());
                  // }
                  //     :
                  () {},
              visible: true,
            )
          ],
        ),
      ],
    );

    // SimpleDialog(
    //   contentPadding: EdgeInsets.only(
    //     bottom: 16.sp,
    //     top: 16.sp,
    //   ),
    //   title: Text('Thông báo',
    //       style: ThemeText.bodySemibold.copyWith(color: AppColors.blue900)),
    //   children: [
    //     _dialogItem(
    //       title: 'Bật thông báo',
    //       context: context,
    //       onTap: () {},
    //       // isLanguageDialog
    //       //     ? () {
    //       //   Injector.getIt<LanguageSelect>().changeLanguage(true);
    //       // }
    //       //     : !profileState.hasNoti
    //       //     ? () async {
    //       //   if (await Permission.calendar.isDenied) {
    //       //     Navigator.pop(context);
    //       //     openSettingDiaLog(
    //       //       context: context,
    //       //     );
    //       //     return;
    //       //   } else {
    //       //     BlocProvider.of<ProfileBloc>(context)
    //       //         .add(TurnOnNotificationEvent());
    //       //     Navigator.pop(context);
    //       //     BlocProvider.of<ProfileBloc>(context)
    //       //         .add(GetUserNameInProfileEvent());
    //       //   }
    //       // }
    //       //     : () {},
    //       visible: false,
    //     ),
    //     _dialogItem(
    //       title: 'Tắt thông báo',
    //       context: context,
    //       onTap:
    //           // isLanguageDialog
    //           //     ? () {
    //           //   Injector.getIt<LanguageSelect>().changeLanguage(false);
    //           // }
    //           //     : profileState.hasNoti
    //           //     ? () {
    //           //   BlocProvider.of<ProfileBloc>(context)
    //           //       .add(TurnOffNotificationEvent());
    //           //   Navigator.pop(context);
    //           //   BlocProvider.of<ProfileBloc>(context)
    //           //       .add(GetUserNameInProfileEvent());
    //           // }
    //           //     :
    //           () {},
    //       visible: true,
    //     ),
    //   ]);
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

  _launchURL() async {
    const url = 'https://actvn.edu.vn/';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      debugPrint('Could not launch $url');
    }
  }
}
