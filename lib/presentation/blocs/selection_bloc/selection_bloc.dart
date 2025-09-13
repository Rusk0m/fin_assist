import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fin_assist/domain/entity/branch.dart';
import 'package:fin_assist/domain/entity/financial_report.dart';
import 'package:fin_assist/domain/entity/organization.dart';

part 'selection_event.dart';
part 'selection_state.dart';

class SelectionBloc extends Bloc<SelectionEvent, SelectionState> {
  SelectionBloc() : super(SelectionState()) {
    on<SelectOrganization>((event, emit) {
      emit(SelectionState(selectedOrganization: event.organization));
    });

    on<SelectBranch>((event, emit) {
      emit(
        SelectionState(
          selectedOrganization: state.selectedOrganization,
          selectedBranch: event.branch,
        ),
      );
    });

    on<SelectReport>((event, emit) {
      emit(
        SelectionState(
          selectedOrganization: state.selectedOrganization,
          selectedBranch: state.selectedBranch,
          selectedReport: event.report,
        ),
      );
    });

    on<ClearOrganization>((event, emit) {
      emit(SelectionState());
    });

    on<ClearBranch>((event, emit) {
      emit(SelectionState(selectedOrganization: state.selectedOrganization));
    });

    on<ClearReport>((event, emit) {
      emit(
        SelectionState(
          selectedOrganization: state.selectedOrganization,
          selectedBranch: state.selectedBranch,
        ),
      );
    });
  }
}
