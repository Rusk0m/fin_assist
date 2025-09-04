import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fin_assist/features/dashboard/presentation/view/dashboard_screen.dart';
import 'package:meta/meta.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState());

  void setTab(DashboardTab tab) {
    emit(DashboardState(tab: tab));
  }
}
