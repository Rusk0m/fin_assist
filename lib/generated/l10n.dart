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

  /// `Sign In`
  String get signIn {
    return Intl.message('Sign In', name: 'signIn', desc: '', args: []);
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

  /// `Log In`
  String get login {
    return Intl.message('Log In', name: 'login', desc: '', args: []);
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google?`
  String get signInWithGoogle {
    return Intl.message(
      'Sign in with Google?',
      name: 'signInWithGoogle',
      desc: '',
      args: [],
    );
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

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
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

  /// `Already have an account? Sign in.`
  String get haveAnAccount {
    return Intl.message(
      'Already have an account? Sign in.',
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

  /// `Dark theme`
  String get darkMode {
    return Intl.message('Dark theme', name: 'darkMode', desc: '', args: []);
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

  /// `Change password`
  String get changePassword {
    return Intl.message(
      'Change password',
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

  /// `Error updating password`
  String get errorUpdatingPassword {
    return Intl.message(
      'Error updating password',
      name: 'errorUpdatingPassword',
      desc: '',
      args: [],
    );
  }

  /// `Change language`
  String get switchLocales {
    return Intl.message(
      'Change language',
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

  /// `Debt analysis ($period months)`
  String get numPeriod {
    return Intl.message(
      'Debt analysis (\$period months)',
      name: 'numPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Debt to equity ratio`
  String get debtToCapital {
    return Intl.message(
      'Debt to equity ratio',
      name: 'debtToCapital',
      desc: '',
      args: [],
    );
  }

  /// `Liabilities structure`
  String get structureOfLiabilities {
    return Intl.message(
      'Liabilities structure',
      name: 'structureOfLiabilities',
      desc: '',
      args: [],
    );
  }

  /// `Short-term`
  String get shortTerm {
    return Intl.message('Short-term', name: 'shortTerm', desc: '', args: []);
  }

  /// `Debt/Cap.`
  String get debitCapital {
    return Intl.message('Debt/Cap.', name: 'debitCapital', desc: '', args: []);
  }

  /// `Debt to equity ratio`
  String get debtToEquityRatio {
    return Intl.message(
      'Debt to equity ratio',
      name: 'debtToEquityRatio',
      desc: '',
      args: [],
    );
  }

  /// `Total debt`
  String get totalDebt {
    return Intl.message('Total debt', name: 'totalDebt', desc: '', args: []);
  }

  /// `Total liabilities`
  String get totalLiabilities {
    return Intl.message(
      'Total liabilities',
      name: 'totalLiabilities',
      desc: '',
      args: [],
    );
  }

  /// `Debt/Assets`
  String get debtAssets {
    return Intl.message('Debt/Assets', name: 'debtAssets', desc: '', args: []);
  }

  /// `Debt to assets ratio`
  String get debtToAssetsRatio {
    return Intl.message(
      'Debt to assets ratio',
      name: 'debtToAssetsRatio',
      desc: '',
      args: [],
    );
  }

  /// `Long-term`
  String get longTerm {
    return Intl.message('Long-term', name: 'longTerm', desc: '', args: []);
  }

  /// `Coefficient`
  String get coefficient {
    return Intl.message('Coefficient', name: 'coefficient', desc: '', args: []);
  }

  /// `Debt/Capital`
  String get debtCapital {
    return Intl.message(
      'Debt/Capital',
      name: 'debtCapital',
      desc: '',
      args: [],
    );
  }

  /// `Low debt burden ✓`
  String get lowDebtBurden {
    return Intl.message(
      'Low debt burden ✓',
      name: 'lowDebtBurden',
      desc: '',
      args: [],
    );
  }

  /// `Moderate debt burden`
  String get moderateDebtBurden {
    return Intl.message(
      'Moderate debt burden',
      name: 'moderateDebtBurden',
      desc: '',
      args: [],
    );
  }

  /// `High debt burden ⚠️`
  String get highDebtBurden {
    return Intl.message(
      'High debt burden ⚠️',
      name: 'highDebtBurden',
      desc: '',
      args: [],
    );
  }

  /// `Very high debt burden ❗`
  String get veryHighDebtBurden {
    return Intl.message(
      'Very high debt burden ❗',
      name: 'veryHighDebtBurden',
      desc: '',
      args: [],
    );
  }

  /// `Detailed debt statistics`
  String get detailedDebtStatistics {
    return Intl.message(
      'Detailed debt statistics',
      name: 'detailedDebtStatistics',
      desc: '',
      args: [],
    );
  }

  /// `Period`
  String get period {
    return Intl.message('Period', name: 'period', desc: '', args: []);
  }

  /// `Debt/Cap.`
  String get debtCap {
    return Intl.message('Debt/Cap.', name: 'debtCap', desc: '', args: []);
  }

  /// `Short-term oblig.`
  String get brieflyMust {
    return Intl.message(
      'Short-term oblig.',
      name: 'brieflyMust',
      desc: '',
      args: [],
    );
  }

  /// `Long-term oblig.`
  String get debtMust {
    return Intl.message(
      'Long-term oblig.',
      name: 'debtMust',
      desc: '',
      args: [],
    );
  }

  /// `Capital`
  String get capital {
    return Intl.message('Capital', name: 'capital', desc: '', args: []);
  }

  /// `Welcome,`
  String get welcome {
    return Intl.message('Welcome,', name: 'welcome', desc: '', args: []);
  }

  /// `No reports for the previous period`
  String get noReports {
    return Intl.message(
      'No reports for the previous period',
      name: 'noReports',
      desc: '',
      args: [],
    );
  }

  /// `Last reporting period`
  String get lastReportingPeriod {
    return Intl.message(
      'Last reporting period',
      name: 'lastReportingPeriod',
      desc: '',
      args: [],
    );
  }

  /// `📊 Key financial indicators`
  String get keyFinancialIndicators {
    return Intl.message(
      '📊 Key financial indicators',
      name: 'keyFinancialIndicators',
      desc: '',
      args: [],
    );
  }

  /// `Revenue`
  String get revenue {
    return Intl.message('Revenue', name: 'revenue', desc: '', args: []);
  }

  /// `Net profit`
  String get netProfit {
    return Intl.message('Net profit', name: 'netProfit', desc: '', args: []);
  }

  /// `Cost of goods sold`
  String get costPrice {
    return Intl.message(
      'Cost of goods sold',
      name: 'costPrice',
      desc: '',
      args: [],
    );
  }

  /// `Cash flow`
  String get cashFlow {
    return Intl.message('Cash flow', name: 'cashFlow', desc: '', args: []);
  }

  /// `💧 Liquidity indicators`
  String get liquidityIndicators {
    return Intl.message(
      '💧 Liquidity indicators',
      name: 'liquidityIndicators',
      desc: '',
      args: [],
    );
  }

  /// `Current liquidity`
  String get currentLiquidity {
    return Intl.message(
      'Current liquidity',
      name: 'currentLiquidity',
      desc: '',
      args: [],
    );
  }

  /// `Quick liquidity`
  String get fastLiquidity {
    return Intl.message(
      'Quick liquidity',
      name: 'fastLiquidity',
      desc: '',
      args: [],
    );
  }

  /// `Norm: > 2.0`
  String get normCurrentLiquidity {
    return Intl.message(
      'Norm: > 2.0',
      name: 'normCurrentLiquidity',
      desc: '',
      args: [],
    );
  }

  /// `Norm: > 1.0`
  String get normFastLiquidity {
    return Intl.message(
      'Norm: > 1.0',
      name: 'normFastLiquidity',
      desc: '',
      args: [],
    );
  }

  /// `📈 Profitability`
  String get profitability {
    return Intl.message(
      '📈 Profitability',
      name: 'profitability',
      desc: '',
      args: [],
    );
  }

  /// `Return on assets`
  String get returnOnAssets {
    return Intl.message(
      'Return on assets',
      name: 'returnOnAssets',
      desc: '',
      args: [],
    );
  }

  /// `Return on capital`
  String get returnOnCapital {
    return Intl.message(
      'Return on capital',
      name: 'returnOnCapital',
      desc: '',
      args: [],
    );
  }

  /// `🏦 Financial stability`
  String get financialStability {
    return Intl.message(
      '🏦 Financial stability',
      name: 'financialStability',
      desc: '',
      args: [],
    );
  }

  /// `Norm: < 1.0`
  String get normDebtCapital {
    return Intl.message(
      'Norm: < 1.0',
      name: 'normDebtCapital',
      desc: '',
      args: [],
    );
  }

  /// `Financial analysis`
  String get financialAnalysis {
    return Intl.message(
      'Financial analysis',
      name: 'financialAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `$period months`
  String get periodMonth {
    return Intl.message(
      '\$period months',
      name: 'periodMonth',
      desc: '',
      args: [],
    );
  }

  /// `Liquidity`
  String get liquidity {
    return Intl.message('Liquidity', name: 'liquidity', desc: '', args: []);
  }

  /// `Debt`
  String get arrears {
    return Intl.message('Debt', name: 'arrears', desc: '', args: []);
  }

  /// `Liquidity analysis ($period months)`
  String get liquidityAnalysisPeriodMonths {
    return Intl.message(
      'Liquidity analysis (\$period months)',
      name: 'liquidityAnalysisPeriodMonths',
      desc: '',
      args: [],
    );
  }

  /// `Liquidity ratios`
  String get liquidityRatios {
    return Intl.message(
      'Liquidity ratios',
      name: 'liquidityRatios',
      desc: '',
      args: [],
    );
  }

  /// `Curr. liq.`
  String get techLiquor {
    return Intl.message('Curr. liq.', name: 'techLiquor', desc: '', args: []);
  }

  /// `Current ratio`
  String get currentLiquidityRatio {
    return Intl.message(
      'Current ratio',
      name: 'currentLiquidityRatio',
      desc: '',
      args: [],
    );
  }

  /// `Quick liq.`
  String get fastLiquor {
    return Intl.message('Quick liq.', name: 'fastLiquor', desc: '', args: []);
  }

  /// `Quick ratio`
  String get quickLiquidityRatio {
    return Intl.message(
      'Quick ratio',
      name: 'quickLiquidityRatio',
      desc: '',
      args: [],
    );
  }

  /// `Detailed liquidity statistics`
  String get detailedLiquidityStatistics {
    return Intl.message(
      'Detailed liquidity statistics',
      name: 'detailedLiquidityStatistics',
      desc: '',
      args: [],
    );
  }

  /// `Cash`
  String get cashResources {
    return Intl.message('Cash', name: 'cashResources', desc: '', args: []);
  }

  /// `Current assets`
  String get techAssets {
    return Intl.message(
      'Current assets',
      name: 'techAssets',
      desc: '',
      args: [],
    );
  }

  /// `Profitability analysis ($period months)`
  String get profitabilityAnalysisPeriodMonths {
    return Intl.message(
      'Profitability analysis (\$period months)',
      name: 'profitabilityAnalysisPeriodMonths',
      desc: '',
      args: [],
    );
  }

  /// `Return on assets and capital (%)`
  String get returnOnAssetsAndCapital {
    return Intl.message(
      'Return on assets and capital (%)',
      name: 'returnOnAssetsAndCapital',
      desc: '',
      args: [],
    );
  }

  /// `Profit margin (%)`
  String get profitMargin {
    return Intl.message(
      'Profit margin (%)',
      name: 'profitMargin',
      desc: '',
      args: [],
    );
  }

  /// `Gross margin`
  String get GrossMargin {
    return Intl.message(
      'Gross margin',
      name: 'GrossMargin',
      desc: '',
      args: [],
    );
  }

  /// `Net margin`
  String get netMargin {
    return Intl.message('Net margin', name: 'netMargin', desc: '', args: []);
  }

  /// `Margin`
  String get margin {
    return Intl.message('Margin', name: 'margin', desc: '', args: []);
  }

  /// `Detailed statistics`
  String get detailedStatistics {
    return Intl.message(
      'Detailed statistics',
      name: 'detailedStatistics',
      desc: '',
      args: [],
    );
  }

  /// `Gross margin (%)`
  String get grossMargin {
    return Intl.message(
      'Gross margin (%)',
      name: 'grossMargin',
      desc: '',
      args: [],
    );
  }

  /// `Profit`
  String get profit {
    return Intl.message('Profit', name: 'profit', desc: '', args: []);
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
