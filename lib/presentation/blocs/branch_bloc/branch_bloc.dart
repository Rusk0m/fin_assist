import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fin_assist/data/model/branch_model/branch_model.dart';
import 'package:fin_assist/domain/entity/branch.dart';
import 'package:fin_assist/domain/use_case/branch_use_case/get_branches_by_organizations_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:fin_assist/domain/use_case/branch_use_case/add_branch_usecase.dart';
import 'package:fin_assist/domain/use_case/branch_use_case/get_branch_by_id_usecase.dart';

part 'branch_event.dart';
part 'branch_state.dart';

class BranchBloc extends Bloc<BranchEvent, BranchState> {
  BranchBloc() : super(BranchInitial()) {
    on<GetBranchesByOrganizationEvent>(_onGetBranchesByOrganization);
    on<GetBranchByIdEvent>(_onGetBranchById);
    on<AddBranchEvent>(_onAddBranch);
    on<ResetBranchStateEvent>(_onResetBranchState);
  }

  Future<void> _onGetBranchesByOrganization(
      GetBranchesByOrganizationEvent event,
      Emitter<BranchState> emit,
      ) async {
    emit(BranchLoading());
    try {
      final branches = await GetIt.instance<GetBranchesByOrganizationsUseCase>().call(event.organizationId);
      emit(BranchesLoadedState(branches!));
    } catch (e) {
      emit(BranchErrorState(e.toString()));
    }
  }

  Future<void> _onGetBranchById(
      GetBranchByIdEvent event,
      Emitter<BranchState> emit,
      ) async {
    emit(BranchLoading());
    try {
      final branch = await GetIt.instance<GetBranchByIdUseCase>().call(event.branchId);

      if (branch != null) {
        emit(BranchLoadedState(branch));
      } else {
        emit(BranchNotFoundState());
      }
    } catch (e) {
      print('BranchBloc: Error loading branch: $e');
      emit(BranchErrorState(e.toString()));
    }
  }

  Future<void> _onAddBranch(
      AddBranchEvent event,
      Emitter<BranchState> emit,
      ) async {
    emit(BranchLoading());
    try {
      await GetIt.instance<AddBranchUseCase>().call(event.branch);
      emit(BranchAddedState(event.branch));
    } catch (e) {
      print('BranchBloc: Error adding branch: $e');
      emit(BranchErrorState(e.toString()));
    }
  }

  void _onResetBranchState(
      ResetBranchStateEvent event,
      Emitter<BranchState> emit,
      ) {
    emit(BranchInitial());
  }
}