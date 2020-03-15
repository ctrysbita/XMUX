import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
class S implements WidgetsLocalizations {
  const S();

  static S current;

  static const GeneratedLocalizationsDelegate delegate =
      GeneratedLocalizationsDelegate();

  static S of(BuildContext context) => Localizations.of<S>(context, S);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get About => "About";
  String get Calendar_Attendance => "Attendance";
  String get Calendar_AttendanceMarkAbsent => "Mark as Absent";
  String get Calendar_AttendanceMarkAttended => "Mark as Attended";
  String get Calendar_AttendanceRate => "Attendance";
  String get Calendar_AttendanceSignIn => "Sign in";
  String get Calendar_AttendanceSignInMarked => "Waiting...";
  String get Calendar_AttendanceSignInSucceeded => "Succeeded";
  String get GMS_Unavailable => "GMS Unavailable";
  String get GMS_UnavailableCaption =>
      "This function requires GMS, which is not working properly on your device. Please login again and make sure your GMS is working properly.";
  String get GMS_UnavailableLoginCaption =>
      "GMS is not working properly on your device. Some functions may not work. Sure to continue?";
  String get General_Cancel => "Cancel";
  String get General_Continue => "Continue";
  String get General_Ignore => "Ignore";
  String get General_Weekday1 => "Monday";
  String get General_Weekday2 => "Tuesday";
  String get General_Weekday3 => "Wednesday";
  String get General_Weekday4 => "Thursday";
  String get General_Weekday5 => "Friday";
  String get General_Weekday6 => "Saturday";
  String get General_Weekday7 => "Sunday";
  String get Settings => "Settings";
  String get Settings_DeveloperOptions => "Developer Options";
  String get Settings_DeveloperOptionsEnableFnUnderDev =>
      "Enable Functions under Development";
  String get Settings_DeveloperOptionsEnableFnUnderDevCaption =>
      "These functions are still under development and are highly unstable";
  String get Settings_DeveloperOptionsNotificationToken =>
      "My Notification Token";
  String get Settings_DeveloperOptionsNotificationTokenCaption =>
      "Press to copy my notification token";
  String get Settings_DeveloperOptionsWarning =>
      "Warning: These functions are for developers and testers only and may cause operational errors or data loss.";
  String get Settings_EditProfile => "Edit Profile";
  String get Settings_Sessions => "Sessions";
  String get Settings_SignOut => "Sign Out";
  String get SignIn_CampusID => "Campus ID";
  String get SignIn_Docs => "Help Docs";
  String get SignIn_ErrorDeprecated =>
      "Please upgrade! The version of app is no longer supported!";
  String get SignIn_ErrorFormat => "Format error, please check.";
  String get SignIn_ErrorGMS => "GMS not working properly.";
  String get SignIn_ErrorInvalidPassword => "Invalid username or password.";
  String get SignIn_InstallGMS => "Install GMS";
  String get SignIn_Password => "Password";
  String get SignIn_Privacy => "Privacy Policy";
  String get SignIn_Read =>
      "By signing in, you agree to our privacy policy & disclaimer";
  String get SignIn_Register => "Register";
  String get SignIn_RegisterCaption =>
      "We still need some information to finish your registration.";
  String get SignIn_RegisterDisplayName => "Display Name";
  String get SignIn_RegisterEmail => "Email";
  String get SignIn_RegisterTitle => "Welcome to XMUM!";
  String get SignIn_SignIn => "Sign in";
  String Calendar_AttendanceSignInFailed(String tip) => "Failed: $tip";
  String General_Error(String tip) => "Error: $tip";
}

class $en extends S {
  const $en();
}

class $zh_CN extends S {
  const $zh_CN();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get Calendar_Attendance => "考勤";
  @override
  String get SignIn_ErrorFormat => "格式不正确，请检查。";
  @override
  String get Settings_DeveloperOptionsWarning =>
      "警告：这些选项仅供开发者及测试人员使用，它们可能会导致您的应用运行异常及数据的丢失或泄漏。";
  @override
  String get SignIn_Register => "注册";
  @override
  String get General_Ignore => "忽略";
  @override
  String get GMS_UnavailableCaption =>
      "该功能需要的谷歌服务在您的设备上没有正常工作，请重新登录并保证您的谷歌服务工作正常。";
  @override
  String get SignIn_ErrorDeprecated => "该版本应用已不再受到支持，请更新！";
  @override
  String get Calendar_AttendanceSignIn => "签到";
  @override
  String get Calendar_AttendanceRate => "出勤率";
  @override
  String get Settings => "设置";
  @override
  String get SignIn_ErrorInvalidPassword => "用户名或密码无效";
  @override
  String get Settings_Sessions => "会话";
  @override
  String get General_Weekday7 => "周日";
  @override
  String get GMS_Unavailable => "谷歌服务不可用";
  @override
  String get General_Weekday6 => "周六";
  @override
  String get General_Weekday5 => "周五";
  @override
  String get General_Weekday4 => "周四";
  @override
  String get Settings_DeveloperOptions => "开发者选项";
  @override
  String get General_Weekday3 => "周三";
  @override
  String get General_Weekday2 => "周二";
  @override
  String get General_Weekday1 => "周一";
  @override
  String get Calendar_AttendanceSignInSucceeded => "签到成功";
  @override
  String get About => "关于";
  @override
  String get Settings_DeveloperOptionsEnableFnUnderDevCaption =>
      "这些功能尚在开发中且十分不稳定";
  @override
  String get Calendar_AttendanceMarkAbsent => "标记为缺席";
  @override
  String get SignIn_RegisterCaption => "我们仍需要以下信息以完成注册。";
  @override
  String get Settings_EditProfile => "更改个人资料";
  @override
  String get SignIn_Read => "登录即代表您同意我们的隐私政策和免责声明";
  @override
  String get General_Cancel => "取消";
  @override
  String get SignIn_InstallGMS => "安装 GMS";
  @override
  String get SignIn_CampusID => "校园ID";
  @override
  String get Calendar_AttendanceSignInMarked => "等待确认···";
  @override
  String get SignIn_Privacy => "隐私政策";
  @override
  String get Calendar_AttendanceMarkAttended => "标记为出席";
  @override
  String get SignIn_Password => "密码";
  @override
  String get Settings_DeveloperOptionsNotificationTokenCaption =>
      "点击以复制我的通知推送令牌";
  @override
  String get Settings_DeveloperOptionsNotificationToken => "通知推送令牌";
  @override
  String get Settings_SignOut => "登出";
  @override
  String get SignIn_Docs => "帮助文档";
  @override
  String get SignIn_ErrorGMS => "GMS 未正常工作";
  @override
  String get SignIn_SignIn => "登录";
  @override
  String get SignIn_RegisterTitle => "欢迎来到 XMUM！";
  @override
  String get Settings_DeveloperOptionsEnableFnUnderDev => "启用正在开发中的功能";
  @override
  String get General_Continue => "继续";
  @override
  String get GMS_UnavailableLoginCaption =>
      "谷歌服务在您的设备上没有正常工作，这将导致部分功能无法使用，继续登录？";
  @override
  String get SignIn_RegisterEmail => "邮箱";
  @override
  String Calendar_AttendanceSignInFailed(String tip) => "签到失败： $tip";
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("en", ""),
      Locale("zh", "CN"),
    ];
  }

  LocaleListResolutionCallback listResolution(
      {Locale fallback, bool withCountry = true}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported, withCountry);
      }
    };
  }

  LocaleResolutionCallback resolution(
      {Locale fallback, bool withCountry = true}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported, withCountry);
    };
  }

  @override
  Future<S> load(Locale locale) {
    final String lang = getLang(locale);
    if (lang != null) {
      switch (lang) {
        case "en":
          S.current = const $en();
          return SynchronousFuture<S>(S.current);
        case "zh_CN":
          S.current = const $zh_CN();
          return SynchronousFuture<S>(S.current);
        default:
        // NO-OP.
      }
    }
    S.current = const S();
    return SynchronousFuture<S>(S.current);
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale, true);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;

  ///
  /// Internal method to resolve a locale from a list of locales.
  ///
  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported,
      bool withCountry) {
    if (locale == null || !_isSupported(locale, withCountry)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  ///
  /// Returns true if the specified locale is supported, false otherwise.
  ///
  bool _isSupported(Locale locale, bool withCountry) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        // Language must always match both locales.
        if (supportedLocale.languageCode != locale.languageCode) {
          continue;
        }

        // If country code matches, return this locale.
        if (supportedLocale.countryCode == locale.countryCode) {
          return true;
        }

        // If no country requirement is requested, check if this locale has no country.
        if (true != withCountry &&
            (supportedLocale.countryCode == null ||
                supportedLocale.countryCode.isEmpty)) {
          return true;
        }
      }
    }
    return false;
  }
}

String getLang(Locale l) => l == null
    ? null
    : l.countryCode != null && l.countryCode.isEmpty
        ? l.languageCode
        : l.toString();
