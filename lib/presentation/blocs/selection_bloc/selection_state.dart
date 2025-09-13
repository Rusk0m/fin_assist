part of 'selection_bloc.dart';

class SelectionState extends Equatable {
  final Organization? selectedOrganization;
  final Branch? selectedBranch;
  final FinancialReportEntity? selectedReport;

  const SelectionState({this.selectedOrganization, this.selectedBranch, this.selectedReport});

  @override
  List<Object?> get props => [selectedOrganization, selectedBranch, selectedReport];
}
