import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_assist/domain/services/economic_indicators_service.dart';
import 'package:fin_assist/domain/use_case/branch_use_case/use_cases.dart';
import 'package:fin_assist/domain/use_case/organization_use_case/use_cases.dart';
import 'package:fin_assist/domain/use_case/user_use_case/get_user_branches_usecase.dart';
import 'package:fin_assist/domain/use_case/user_use_case/get_user_by_id_usecase.dart';
import 'package:fin_assist/domain/use_case/user_use_case/get_user_organization_usecase.dart';
import 'package:fin_assist/domain/use_case/user_use_case/update_user_usecase.dart';
import 'package:fin_assist/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:fin_assist/presentation/blocs/dashboard_cubit/dashboard_cubit.dart';
import 'package:fin_assist/presentation/blocs/financial_report_bloc/financial_report_bloc.dart';
import 'package:fin_assist/presentation/blocs/organization_bloc/organization_bloc.dart';
import 'package:fin_assist/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'data/repository/repositories_impl.dart';
import 'domain/repository/repositories.dart';
import 'domain/use_case/auth_use_case/usecases.dart';
import 'domain/use_case/financial_report_use_case/use_cases.dart';
import 'presentation/blocs/branch_bloc/branch_bloc.dart';
import 'presentation/blocs/selection_bloc/selection_bloc.dart';
import 'theme/cubit/theme_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() async {
  getIt.registerSingleton<firebase_auth.FirebaseAuth>(
    firebase_auth.FirebaseAuth.instance,
  );
  getIt.registerSingleton<GoogleSignIn>(GoogleSignIn());
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  //-------------------------Services------------------------------
  getIt.registerSingleton<EconomicIndicatorsService>(
    EconomicIndicatorsService(),
  );

  //------------------------Repository--------------------------
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      firebaseAuth: getIt<firebase_auth.FirebaseAuth>(),
      googleSignIn: getIt<GoogleSignIn>(),
    ),
  );
  getIt.registerSingleton<BranchRepository>(
    BranchRepositoryImpl(getIt<FirebaseFirestore>()),
  );

  getIt.registerSingleton<OrganizationRepository>(
    OrganizationRepositoryImpl(getIt<FirebaseFirestore>()),
  );

  getIt.registerSingleton<FinancialReportRepository>(
    FinancialReportRepositoryImpl(getIt<FirebaseFirestore>()),
  );

  getIt.registerSingleton<UserRepository>(
    UserRepositoryImpl(firestore: getIt<FirebaseFirestore>()),
  );

  //------------------Use cases------------------------
  //Auth use-case
  getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt<AuthRepository>()));
  //getIt.registerSingleton<RegisterUseCase>(RegisterUseCase(getIt<AuthRepository>()));
  getIt.registerSingleton<LogoutUseCase>(
    LogoutUseCase(getIt<AuthRepository>()),
  );
  getIt.registerSingleton<CheckAuthStatusUseCase>(
    CheckAuthStatusUseCase(getIt<AuthRepository>()),
  );
  getIt.registerSingleton<ForgotPasswordUseCase>(
    ForgotPasswordUseCase(getIt<AuthRepository>()),
  );
  getIt.registerSingleton<GoogleLoginUseCase>(
    GoogleLoginUseCase(getIt<AuthRepository>()),
  );

  //Branch use-case
  getIt.registerSingleton<AddBranchUseCase>(
    AddBranchUseCase(branchRepository: getIt<BranchRepository>()),
  );
  getIt.registerSingleton<GetBranchByIdUseCase>(
    GetBranchByIdUseCase(branchRepository: getIt<BranchRepository>()),
  );
  getIt.registerSingleton<GetBranchesByOrganizationsUseCase>(
    GetBranchesByOrganizationsUseCase(
      branchRepository: getIt<BranchRepository>(),
    ),
  );

  //Financial report use-case
  getIt.registerSingleton<GetEconomicIndicatorsForBranchUseCase>(
    GetEconomicIndicatorsForBranchUseCase(
      service: getIt<EconomicIndicatorsService>(),
      repository: getIt<FinancialReportRepository>(),
    ),
  );
  getIt.registerSingleton<GetLatestReportUseCase>(
    GetLatestReportUseCase(
      financialReportRepository: getIt<FinancialReportRepository>(),),
  );
  getIt.registerSingleton<GetReportByPeriodUseCase>(
    GetReportByPeriodUseCase(
      financialReportRepository: getIt<FinancialReportRepository>(),),
  );
  getIt.registerSingleton<GetReportsByBranchUseCase>(
    GetReportsByBranchUseCase(
      financialReportRepository: getIt<FinancialReportRepository>(),),
  );
  getIt.registerSingleton<SubmitReportUseCase>(
    SubmitReportUseCase(
      financialReportRepository: getIt<FinancialReportRepository>(),),
  );

  //Organization use-case
  getIt.registerSingleton<AddOrganizationUseCase>(
      AddOrganizationUseCase(getIt<OrganizationRepository>())
  );
  getIt.registerSingleton<GetOrganizationByIdUseCase>(
      GetOrganizationByIdUseCase(getIt<OrganizationRepository>())
  );
  getIt.registerSingleton<GetOrganizationsByOwnerIdUseCase>(
      GetOrganizationsByOwnerIdUseCase(getIt<OrganizationRepository>())
  );

  //User use-case
  getIt.registerSingleton<GetUserBranchesUseCase>(
      GetUserBranchesUseCase(userRepository: getIt<UserRepository>())
  );
  getIt.registerSingleton<GetUserByIdUseCase>(
      GetUserByIdUseCase(userRepository: getIt<UserRepository>())
  );
  getIt.registerSingleton<GetUserOrganizationUseCase>(
      GetUserOrganizationUseCase(userRepository: getIt<UserRepository>())
  );
  getIt.registerSingleton<UpdateUserUseCase>(
      UpdateUserUseCase(userRepository: getIt<UserRepository>())
  );

  // --------------------------BLoC-----------------------------
  getIt.registerSingleton<AuthBloc>(
    AuthBloc(repository: getIt<AuthRepository>()),
  );

  getIt.registerSingleton<DashboardCubit>(
      DashboardCubit()
  );
  getIt.registerSingleton<ThemeCubit>(
      ThemeCubit()
  );

  getIt.registerSingleton <FinancialReportBloc>(
      FinancialReportBloc()
  );
  getIt.registerSingleton <BranchBloc>(
      BranchBloc()
  );
  getIt.registerSingleton <SelectionBloc>(
      SelectionBloc()
  );
  getIt.registerSingleton <OrganizationBloc>(
      OrganizationBloc()
  );

  getIt.registerFactory<UserBloc>(
        () => UserBloc(
          userRepository: getIt<UserRepository>(),
          authBloc: getIt<AuthBloc>(),
    ),
  );

}