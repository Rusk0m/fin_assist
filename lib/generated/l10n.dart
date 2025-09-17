// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `SignIn`
  String get signIn {
    return Intl.message('SignIn', name: 'signIn', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get signInWithGoogle {
    return Intl.message(
      'Sign in with Google',
      name: 'signInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password reset email sent`
  String get passwordResetEmailSent {
    return Intl.message(
      'Password reset email sent',
      name: 'passwordResetEmailSent',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `No account? Register.`
  String get noAccountRegister {
    return Intl.message(
      'No account? Register.',
      name: 'noAccountRegister',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get Registration {
    return Intl.message(
      'Registration',
      name: 'Registration',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message('Name', name: 'Name', desc: '', args: []);
  }

  /// `Registration`
  String get registration {
    return Intl.message(
      'Registration',
      name: 'registration',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Fill in all fields`
  String get fillInAllFields {
    return Intl.message(
      'Fill in all fields',
      name: 'fillInAllFields',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Already have an account? Login.`
  String get haveAnAccount {
    return Intl.message(
      'Already have an account? Login.',
      name: 'haveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsTitleAppBar {
    return Intl.message(
      'Settings',
      name: 'settingsTitleAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Other settings`
  String get otherSettings {
    return Intl.message(
      'Other settings',
      name: 'otherSettings',
      desc: '',
      args: [],
    );
  }

  /// `Profile details`
  String get profileDetails {
    return Intl.message(
      'Profile details',
      name: 'profileDetails',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get darkMode {
    return Intl.message('Dark mode', name: 'darkMode', desc: '', args: []);
  }

  /// `About application`
  String get aboutApplication {
    return Intl.message(
      'About application',
      name: 'aboutApplication',
      desc: '',
      args: [],
    );
  }

  /// `Help/FAQ`
  String get helpfaq {
    return Intl.message('Help/FAQ', name: 'helpfaq', desc: '', args: []);
  }

  /// `Deactivate my account`
  String get deactivateMyAccount {
    return Intl.message(
      'Deactivate my account',
      name: 'deactivateMyAccount',
      desc: '',
      args: [],
    );
  }

  /// `Organization`
  String get organization {
    return Intl.message(
      'Organization',
      name: 'organization',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Edit profile`
  String get editProfile {
    return Intl.message(
      'Edit profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Invalid password`
  String get invalidPassword {
    return Intl.message(
      'Invalid password',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password updated`
  String get passwordUpdated {
    return Intl.message(
      'Password updated',
      name: 'passwordUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Error Updating Password`
  String get errorUpdatingPassword {
    return Intl.message(
      'Error Updating Password',
      name: 'errorUpdatingPassword',
      desc: '',
      args: [],
    );
  }

  /// `Switch locales`
  String get switchLocales {
    return Intl.message(
      'Switch locales',
      name: 'switchLocales',
      desc: '',
      args: [],
    );
  }

  /// `Enter new name`
  String get enterNewName {
    return Intl.message(
      'Enter new name',
      name: 'enterNewName',
      desc: '',
      args: [],
    );
  }

  /// `Enter new email`
  String get enterNewEmail {
    return Intl.message(
      'Enter new email',
      name: 'enterNewEmail',
      desc: '',
      args: [],
    );
  }

  /// `Анализ задолженности ($period месяцев)`
  String get numPeriod {
    return Intl.message(
      'Анализ задолженности (\$period месяцев)',
      name: 'numPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Отношение долга к собственному капиталу`
  String get debtToCapital {
    return Intl.message(
      'Отношение долга к собственному капиталу',
      name: 'debtToCapital',
      desc: '',
      args: [],
    );
  }

  /// `Структура обязательств`
  String get structureOfLiabilities {
    return Intl.message(
      'Структура обязательств',
      name: 'structureOfLiabilities',
      desc: '',
      args: [],
    );
  }

  /// `Краткосрочные`
  String get shortTerm {
    return Intl.message('Краткосрочные', name: 'shortTerm', desc: '', args: []);
  }

  /// `Долг/Кап.`
  String get debitCapital {
    return Intl.message('Долг/Кап.', name: 'debitCapital', desc: '', args: []);
  }

  /// `Отношение долга к капиталу`
  String get debtToEquityRatio {
    return Intl.message(
      'Отношение долга к капиталу',
      name: 'debtToEquityRatio',
      desc: '',
      args: [],
    );
  }

  /// `Общий долг`
  String get totalDebt {
    return Intl.message('Общий долг', name: 'totalDebt', desc: '', args: []);
  }

  /// `Всего обязательств`
  String get totalLiabilities {
    return Intl.message(
      'Всего обязательств',
      name: 'totalLiabilities',
      desc: '',
      args: [],
    );
  }

  /// `Долг/Активы`
  String get debtAssets {
    return Intl.message('Долг/Активы', name: 'debtAssets', desc: '', args: []);
  }

  /// `Доля долга в активах`
  String get debtToAssetsRatio {
    return Intl.message(
      'Доля долга в активах',
      name: 'debtToAssetsRatio',
      desc: '',
      args: [],
    );
  }

  /// `Долгосрочные`
  String get longTerm {
    return Intl.message('Долгосрочные', name: 'longTerm', desc: '', args: []);
  }

  /// `Коэффициент`
  String get coefficient {
    return Intl.message('Коэффициент', name: 'coefficient', desc: '', args: []);
  }

  /// `Долг/Капитал`
  String get debtCapital {
    return Intl.message(
      'Долг/Капитал',
      name: 'debtCapital',
      desc: '',
      args: [],
    );
  }

  /// `Низкая долговая нагрузка ✓`
  String get lowDebtBurden {
    return Intl.message(
      'Низкая долговая нагрузка ✓',
      name: 'lowDebtBurden',
      desc: '',
      args: [],
    );
  }

  /// `Умеренная долговая нагрузка`
  String get moderateDebtBurden {
    return Intl.message(
      'Умеренная долговая нагрузка',
      name: 'moderateDebtBurden',
      desc: '',
      args: [],
    );
  }

  /// `Высокая долговая нагрузка ⚠️`
  String get highDebtBurden {
    return Intl.message(
      'Высокая долговая нагрузка ⚠️',
      name: 'highDebtBurden',
      desc: '',
      args: [],
    );
  }

  /// `Очень высокая долговая нагрузка ❗`
  String get veryHighDebtBurden {
    return Intl.message(
      'Очень высокая долговая нагрузка ❗',
      name: 'veryHighDebtBurden',
      desc: '',
      args: [],
    );
  }

  /// `Детальная статистика задолженности`
  String get detailedDebtStatistics {
    return Intl.message(
      'Детальная статистика задолженности',
      name: 'detailedDebtStatistics',
      desc: '',
      args: [],
    );
  }

  /// `Период`
  String get period {
    return Intl.message('Период', name: 'period', desc: '', args: []);
  }

  /// `Долг/Кап.`
  String get debtCap {
    return Intl.message('Долг/Кап.', name: 'debtCap', desc: '', args: []);
  }

  /// `Кратк. обяз.`
  String get brieflyMust {
    return Intl.message(
      'Кратк. обяз.',
      name: 'brieflyMust',
      desc: '',
      args: [],
    );
  }

  /// `Долг. обяз.`
  String get debtMust {
    return Intl.message('Долг. обяз.', name: 'debtMust', desc: '', args: []);
  }

  /// `Капитал`
  String get capital {
    return Intl.message('Капитал', name: 'capital', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
