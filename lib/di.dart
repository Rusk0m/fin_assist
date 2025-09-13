import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_assist/data/repository/auth_repository_impl.dart';
import 'package:fin_assist/data/repository/branch_repository_impl.dart';
import 'package:fin_assist/data/repository/financial_report_repository_impl.dart';
import 'package:fin_assist/data/repository/organization_repository_impl.dart';
import 'package:fin_assist/data/repository/user_repository_impl.dart';
import 'package:fin_assist/domain/repository/auth_repository.dart';
import 'package:fin_assist/domain/repository/branch_repository.dart';
import 'package:fin_assist/domain/repository/financial_report_repository.dart';
import 'package:fin_assist/domain/repository/organization_repository.dart';
import 'package:fin_assist/domain/repository/user_repository.dart';
import 'package:fin_assist/domain/use_case/auth_use_case/check_auth_status_usecase.dart';
import 'package:fin_assist/domain/use_case/auth_use_case/forgot_password_usecase.dart';
import 'package:fin_assist/domain/use_case/auth_use_case/google_login_usecase.dart';
import 'package:fin_assist/domain/use_case/auth_use_case/login_usecase.dart';
import 'package:fin_assist/domain/use_case/auth_use_case/logout_usecase.dart';
import 'package:fin_assist/domain/use_case/branch_use_case/add_branch_usecase.dart';
import 'package:fin_assist/domain/use_case/branch_use_case/get_branch_by_id_usecase.dart';
import 'package:fin_assist/domain/use_case/branch_use_case/get_branches_by_organizations_usecase.dart';
import 'package:fin_assist/domain/use_case/organization_use_case/add_organization_usecase.dart';
import 'package:fin_assist/domain/use_case/organization_use_case/get_organization_by_id_usecase.dart';
import 'package:fin_assist/domain/use_case/organization_use_case/get_organizations_by_owner_usecase.dart';
import 'package:fin_assist/presentation/blocs/auth_bloc/auth_bloc.dart' show AuthBloc;
import 'package:fin_assist/presentation/blocs/branch_bloc/branch_bloc.dart';
import 'package:fin_assist/presentation/blocs/financial_report_bloc/financial_report_bloc.dart';
import 'package:fin_assist/presentation/blocs/organization_bloc/organization_bloc.dart';
import 'package:fin_assist/presentation/blocs/selection_bloc/selection_bloc.dart';
import 'package:fin_assist/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'domain/use_case/finantial_report_use_case/get_latest_report_usecase.dart';
import 'domain/use_case/finantial_report_use_case/get_report_by_period_usecase.dart';
import 'domain/use_case/finantial_report_use_case/get_reports_by_branch_usecase.dart';
import 'domain/use_case/finantial_report_use_case/submit_report_usecase.dart';
import 'domain/use_case/user_use_case/add_user_usecase.dart';

final getIt = GetIt.instance;

void setupDependencies() async {

  getIt.registerSingleton<firebase_auth.FirebaseAuth>(firebase_auth.FirebaseAuth.instance);
  getIt.registerSingleton<GoogleSignIn>(GoogleSignIn());

  // Firebase Firestore
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  // Repositories
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      firebaseAuth: getIt<firebase_auth.FirebaseAuth>(),
      googleSignIn: getIt<GoogleSignIn>(),
    ),
  );

  getIt.registerSingleton<OrganizationRepository>(
    OrganizationRepositoryImpl(
      getIt<FirebaseFirestore>(),
    ),
  );

  getIt.registerSingleton<BranchRepository>(
    BranchRepositoryImpl(
      getIt<FirebaseFirestore>(),
    ),
  );

  getIt.registerSingleton<FinancialReportRepository>(
    FinancialReportRepositoryImpl(
      getIt<FirebaseFirestore>(),
    ),
  );

  getIt.registerSingleton<UserRepository>(
    UserRepositoryImpl(firestore: getIt<FirebaseFirestore>()),
  );

  // Use cases - Auth
  getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt<AuthRepository>()));
  getIt.registerSingleton<LogoutUseCase>(LogoutUseCase(getIt<AuthRepository>()));
  getIt.registerSingleton<CheckAuthStatusUseCase>(CheckAuthStatusUseCase(getIt<AuthRepository>()));
  getIt.registerSingleton<ForgotPasswordUseCase>(ForgotPasswordUseCase(getIt<AuthRepository>()));
  getIt.registerSingleton<GoogleLoginUseCase>(GoogleLoginUseCase(getIt<AuthRepository>()));

  // Use cases - Organization
  getIt.registerSingleton<GetOrganizationsByOwnerIdUseCase>(
      GetOrganizationsByOwnerIdUseCase(getIt<OrganizationRepository>())
  );
  getIt.registerSingleton<GetOrganizationByIdUseCase>(
      GetOrganizationByIdUseCase(getIt<OrganizationRepository>())
  );
  getIt.registerSingleton<AddOrganizationUseCase>(
      AddOrganizationUseCase(getIt<OrganizationRepository>())
  );

  // Use cases - Branch
  getIt.registerSingleton<AddBranchUseCase>(
      AddBranchUseCase(branchRepository: getIt<BranchRepository>())
  );
  getIt.registerSingleton<GetBranchByIdUseCase>(
      GetBranchByIdUseCase(branchRepository: getIt<BranchRepository>())
  );
  getIt.registerSingleton<GetBranchesByOrganizationsUseCase>(
      GetBranchesByOrganizationsUseCase(branchRepository: getIt<BranchRepository>())
  );

  // Use cases - Financial Report
  getIt.registerSingleton<GetLatestReportUseCase>(
      GetLatestReportUseCase(financialReportRepository: getIt<FinancialReportRepository>())
  );
  getIt.registerSingleton<GetReportByPeriodUseCase>(
      GetReportByPeriodUseCase(financialReportRepository: getIt<FinancialReportRepository>())
  );
  getIt.registerSingleton<GetReportsByBranchUseCase>(
      GetReportsByBranchUseCase(financialReportRepository: getIt<FinancialReportRepository>())
  );
  getIt.registerSingleton<SubmitReportUseCase>(
      SubmitReportUseCase(financialReportRepository: getIt<FinancialReportRepository>())
  );

  // Use cases - User
  getIt.registerSingleton<AddUserUseCase>(
      AddUserUseCase(userRepository: getIt<UserRepository>())
  );

  // BLoC
  getIt.registerSingleton<AuthBloc>(AuthBloc(repository: getIt<AuthRepository>()));
  getIt.registerSingleton<OrganizationBloc>(OrganizationBloc());
  getIt.registerSingleton<BranchBloc>(BranchBloc());
  getIt.registerSingleton<FinancialReportBloc>(FinancialReportBloc());
  getIt.registerSingleton<SelectionBloc>(SelectionBloc());
  getIt.registerSingleton<UserBloc>(UserBloc(userRepository: getIt<UserRepository>()));
}