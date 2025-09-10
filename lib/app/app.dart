import 'package:fin_assist/di.dart';
import 'package:fin_assist/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fin_assist/generated/l10n.dart';
import 'package:fin_assist/routes/routes.dart';
import 'package:fin_assist/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>()..add(CheckAuthStatusEvent()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: darkTheme,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: '/',
      ),
    );
  }
}