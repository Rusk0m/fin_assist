part of 'dashboard_cubit.dart';

enum DashboardTab { catalog, comparison, profile }

final class DashboardState extends Equatable {

  final DashboardTab tab;

  const DashboardState({
    this.tab = DashboardTab.catalog,
  });

  int get tabIndex => tab.index;

  @override
  List<Object> get props => [tab];
}