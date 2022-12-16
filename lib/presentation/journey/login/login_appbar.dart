import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.sp),
        child: Row(
          children: [
            // BackButton(color: SignInConstants.colorDefault,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Đăng nhập',
                  style: TextStyle(
                      fontFamily: "MR",
                      color: Colors.blue[800]!,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                Container(
                  width: 30.sp,
                  height: 2.5.sp,
                  decoration: BoxDecoration(
                      color: Colors.blue[800]!,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.infinity, 64);
}
