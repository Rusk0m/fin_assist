part of 'branch_bloc.dart';

abstract class BranchState extends Equatable {
  const BranchState();

  @override
  List<Object> get props => [];
}

class BranchInitial extends BranchState {}

class BranchLoading extends BranchState {}

class BranchesLoadedState extends BranchState {
  final List<Branch> branches;

  const BranchesLoadedState(this.branches);

  @override
  List<Object> get props => [branches];
}

class BranchLoadedState extends BranchState {
  final Branch branch;

  const BranchLoadedState(this.branch);

  @override
  List<Object> get props => [branch];
}

class BranchNotFoundState extends BranchState {}

class BranchAddedState extends BranchState {
  final Branch branch;

  const BranchAddedState(this.branch);

  @override
  List<Object> get props => [branch];
}

class BranchErrorState extends BranchState {
  final String message;

  const BranchErrorState(this.message);

  @override
  List<Object> get props => [message];
}