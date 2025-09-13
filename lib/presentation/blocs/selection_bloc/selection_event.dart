part of 'selection_bloc.dart';

sealed class SelectionEvent extends Equatable {
  const SelectionEvent();
}

class SelectOrganization extends SelectionEvent {
  final Organization organization;
  const SelectOrganization(this.organization);

  @override
  List<Object?> get props => [organization];
}

class SelectBranch extends SelectionEvent {
  final Branch branch;
  const SelectBranch(this.branch);

  @override
  List<Object?> get props => [branch];
}

class SelectReport extends SelectionEvent {
  final FinancialReportEntity report;
  const SelectReport(this.report);

  @override
  List<Object?> get props => [FinancialReportEntity];
}

class ClearOrganization extends SelectionEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ClearBranch extends SelectionEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ClearReport extends SelectionEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}