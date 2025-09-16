part of 'branch_bloc.dart';

abstract class BranchEvent extends Equatable {
  const BranchEvent();

  @override
  List<Object> get props => [];
}

class GetBranchesByOrganizationEvent extends BranchEvent {
  final String organizationId;

  const GetBranchesByOrganizationEvent(this.organizationId);

  @override
  List<Object> get props => [organizationId];
}

class GetBranchByIdEvent extends BranchEvent {
  final String branchId;

  const GetBranchByIdEvent(this.branchId);

  @override
  List<Object> get props => [branchId];
}

class GetBranchesByListIdEvent extends BranchEvent {
  final List<String> branchesId;

  const GetBranchesByListIdEvent(this.branchesId);

  @override
  List<Object> get props => [branchesId];
}

class AddBranchEvent extends BranchEvent {
  final Branch branch;

  const AddBranchEvent(this.branch);

  @override
  List<Object> get props => [branch];
}

class ResetBranchStateEvent extends BranchEvent {}