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
      appBar: const AppBarWidget(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: AppDimens.space_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: AppDimens.height_120,
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
              SizedBox(height: AppDimens.height_64),
              Form(
                key: controller.textFormKey,
                child: Column(
                  children: [
                    TextFieldWidget(
                      validate: (value) {
                        if (value!.isEmpty &&
                            controller.isPasswordFocused.value) {
                          return "Tên đăng nhập không được bỏ trống";
                        }
                      },
                      labelText: "Tài khoản",
                      controller: controller.accountController,
                      textStyle: ThemeText.bodyRegular.blue900,
                      colorBoder: AppColors.blue900,
                      onSubmitted: (account) {
                        if (controller.textFormKey.currentState!.validate()) {
                          controller.accountController.text = account;
                          controller.passwordFocusNode.requestFocus();
                        }
                      },
                      focusNode: controller.accountFocusNode,
                      inputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: AppDimens.height_16,
                    ),
                    Obx(
                      () {
                        return TextFieldWidget(
                          validate: (value) {
                            if (value!.isEmpty &&
                                controller.isPasswordFocused.value) {
                              return "Mật khẩu không được bỏ trống";
                            }
                            return null;
                          },
                          colorBoder: AppColors.blue900,
                          labelText: "Mật khẩu",
                          controller: controller.passwordController,
                          textStyle: ThemeText.bodyRegular.blue900,
                          obscureText: !controller.isShowingPassword.value,
                          focusNode: controller.passwordFocusNode,
                          inputAction: TextInputAction.done,
                          seffixIcon: IconButton(
                            onPressed: controller.rxLoadedType.value ==
                                    LoadedType.start
                                ? null
                                : controller.onPressedShowPassword,
                            icon: Icon(
                              !controller.isShowingPassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.blue900,
                            ),
                          ),
                          onSubmitted: (password) {
                            controller.passwordController.text = password;
                            _setOnClickLoginButton(context);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppDimens.height_80,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: AppDimens.height_90,
        width: double.infinity,
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: AppDimens.height_60,
                width: double.infinity,
                color: AppColors.grey300,
              ),
            ),
            Positioned(
              right: AppDimens.width_20,
              child: Obx(
                () => GestureDetector(
                  onTap: controller.rxLoadedType.value == LoadedType.start
                      ? null
                      : () => _setOnClickLoginButton(context),
                  child: Container(
                    height: AppDimens.height_56,
                    width: AppDimens.width_84,
                    decoration: BoxDecoration(
                      color: AppColors.blue900,
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppDimens.space_10),
                      ),
                    ),
                    child: controller.rxLoadedType.value == LoadedType.start
                        ? const LoadingWidget(
                            color: AppColors.bianca,
                          )
                        : Icon(
                            Icons.arrow_forward_rounded,
                            size: AppDimens.space_40,
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _setOnClickLoginButton(BuildContext context) async {
    controller.isPasswordFocused.value = true;

    if (controller.textFormKey.currentState!.validate()) {
      await controller.onPressedLogin();
    }
  }
}
