import 'package:fin_assist/app/app.dart';
import 'package:fin_assist/di.dart';
import 'package:fin_assist/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:fin_assist/theme/cubit/theme_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(
          create: (context) => getIt<AuthBloc>()..add(CheckAuthStatusEvent()),
        ),
      ],
      child: App(),
    ),
  );
}
