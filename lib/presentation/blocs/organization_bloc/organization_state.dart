// bloc/organization_bloc/organization_state.dart
part of 'organization_bloc.dart';

abstract class OrganizationState extends Equatable {
  const OrganizationState();

  @override
  List<Object> get props => [];
}

class OrganizationInitial extends OrganizationState {}

class OrganizationLoading extends OrganizationState {}

class OrganizationsLoadedState extends OrganizationState {
  final List<Organization> organizations;

  const OrganizationsLoadedState(this.organizations);

  @override
  List<Object> get props => [organizations];
}

class OrganizationLoadedState extends OrganizationState {
  final Organization organization;

  const OrganizationLoadedState(this.organization);

  @override
  List<Object> get props => [organization];
}

class OrganizationNotFoundState extends OrganizationState {}

class OrganizationAddedState extends OrganizationState {
  final Organization organization;

  const OrganizationAddedState(this.organization);

  @override
  List<Object> get props => [organization];
}

class OrganizationErrorState extends OrganizationState {
  final String message;

  const OrganizationErrorState(this.message);

  @override
  List<Object> get props => [message];
}