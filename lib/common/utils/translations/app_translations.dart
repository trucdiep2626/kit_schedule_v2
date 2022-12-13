import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en_string.dart';
import 'vi_string.dart';

const Iterable<Locale> appSupportedLocales = [Locale('vi', 'VN'), Locale('en', 'US')];

class AppTranslations extends Translations {
  static const String localeCodeVi = 'vi_VN';
  static const String localeCodeEn = 'en_US';

  @override
  Map<String, Map<String, String>> get keys => {
    localeCodeVi: viString,
    localeCodeEn: enString,
  };

  static String unknownError = 'unknownError';
  static String noConnectionError = 'noConnectionError';
}

class TransactionConstants {
  static const unknownError = 'unknownError';
  static const noConnectionError = 'noConnectionError';
  static const mainNavigationHome = 'main.navigation.home';
  static const mainNavigationFinance = 'main.navigation.finance';
  static const mainNavigationWorkflow = 'main.navigation.workflow';
  static const mainNavigationAccount = 'main.navigation.account';
}