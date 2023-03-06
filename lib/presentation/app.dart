import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/controllers/analytics_controller.dart';

import 'app_pages.dart';
import 'theme/theme_data.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: AppBinding(),
          initialRoute: AppRoutes.splash,
          getPages: myPages,
          translations: AppTranslations(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: appSupportedLocales,
          locale: appSupportedLocales.first,
          fallbackLocale: appSupportedLocales.first,
          theme: appTheme,
          navigatorObservers: [

              getIt<AnalyticsController>().getAnalyticsObserver()
          ],
          builder: (context, child) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                hideKeyboard();
              },
              child: child,
            );
          },
        );
      },
    );
  }
}
