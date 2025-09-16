import 'package:fin_assist/app/app.dart';
import 'package:fin_assist/di.dart';
import 'package:fin_assist/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:fin_assist/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:fin_assist/theme/cubit/theme_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'locale/locale_cubit.dart';
import 'presentation/blocs/branch_bloc/branch_bloc.dart';
import 'presentation/blocs/financial_report_bloc/financial_report_bloc.dart';
import 'presentation/blocs/organization_bloc/organization_bloc.dart';
import 'presentation/blocs/selection_bloc/selection_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(create: (_) => getIt<LocaleCubit>()),
        BlocProvider(
          create: (context) => getIt<AuthBloc>()..add(CheckAuthStatusEvent()),
        ),
        BlocProvider(create: (_) => getIt<UserBloc>()),
        BlocProvider<OrganizationBloc>(
          create: (context) => getIt<OrganizationBloc>(),
        ),
        BlocProvider<BranchBloc>(create: (context) => getIt<BranchBloc>()),
        BlocProvider<FinancialReportBloc>(
          create: (context) => getIt<FinancialReportBloc>(),
        ),
        BlocProvider<SelectionBloc>(
          create: (context) => getIt<SelectionBloc>(),
        ),
      ],
      child: App(),
    ),
  );
}
