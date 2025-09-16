import 'package:fin_assist/di.dart';
import 'package:fin_assist/generated/l10n.dart';
import 'package:fin_assist/locale/locale_cubit.dart';
import 'package:fin_assist/routes/routes.dart';
import 'package:fin_assist/theme/app_theme.dart';
import 'package:fin_assist/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, theme) {
        return BlocBuilder<LocaleCubit, Locale>(
          builder: (context, localeState) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: theme.isDark ? darkTheme : lightTheme,
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: localeState,
              supportedLocales: S.delegate.supportedLocales,
              onGenerateRoute: AppRouter.generateRoute,
              initialRoute: '/',
            );
          },
        );
      },
    );
  }
}