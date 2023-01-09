import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/journey/login/login_appbar.dart';
import 'package:kit_schedule_v2/presentation/journey/login/login_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/loading_widget.dart';
import 'package:kit_schedule_v2/presentation/widgets/text_field_widget.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    return Scaffold(
        backgroundColor: AppColors.bianca,
        appBar: AppBarWidget(),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 120.sp,
                ),
                FittedBox(
                  child: Text(
                    "Chào mừng bạn đến với",
                    style: ThemeText.heading2.blue900.w500(),
                  ),
                ),
                Text(
                  "Kit Schedule",
                  style: ThemeText.heading1.blue900.s36.w700(),
                ),
                SizedBox(height: 65.sp),
                Form(
                    key: controller.textFormKey,
                    child: Column(
                      children: [
                        TextFieldWidget(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Tên đăng nhập không được bỏ trống";
                            }
                            return null;
                          },
                          labelText: "Tài khoản",
                          controller: controller.accountController,
                          textStyle: ThemeText.bodyRegular.blue900,
                          colorBoder: AppColors.blue900,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Obx(() => TextFieldWidget(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Mật khẩu không được bỏ trống";
                                }
                                return null;
                              },
                              colorBoder: AppColors.blue900,
                              labelText: "Mật khẩu",
                              controller: controller.passwordController,
                              textStyle: ThemeText.bodyRegular.blue900,
                              obscureText: !controller.isShow.value,
                              seffixIcon: IconButton(
                                onPressed: controller.rxLoginLoadedType.value ==
                                        LoadedType.start
                                    ? () {}
                                    : () => controller.onPressedShowPassword(),
                                icon: Icon(
                                  !controller.isShow.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColors.blue900,
                                ),
                              ),
                              onSubmitted: (pass) {
                                controller.passwordController.text = pass;
                                _setOnClickLoginButton(context);
                              },
                            )),
                      ],
                    )),
                SizedBox(
                  height: 80.sp,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
            height: 90.h,
            width: double.infinity,
            color: Colors.transparent,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 60.sp,
                    width: double.infinity,
                    color: AppColors.grey300,
                  ),
                ),
                Positioned(
                  right: 20.h,
                  child: Obx(() => GestureDetector(
                        onTap: controller.rxLoginLoadedType.value ==
                                LoadedType.start
                            ? null
                            : () => _setOnClickLoginButton(context),
                        child: Container(
                          height: 57.sp,
                          width: 85.sp,
                          decoration: BoxDecoration(
                              color: AppColors.blue900,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: controller.rxLoginLoadedType.value ==
                                  LoadedType.start
                              ? _loadingUI()
                              : Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 40.sp,
                                  color: Colors.white,
                                ),
                        ),
                      )),
                )
              ],
            )));
  }

  _loadingUI() {
    return const LoadingWidget(
      color: AppColors.bianca,
    );
  }

  Future _setOnClickLoginButton(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (controller.textFormKey.currentState!.validate()) {
      await controller.onPressedLogin();
    }
  }
}
