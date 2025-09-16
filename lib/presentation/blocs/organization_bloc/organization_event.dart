// bloc/organization_bloc/organization_event.dart
part of 'organization_bloc.dart';

abstract class OrganizationEvent extends Equatable {
  const OrganizationEvent();

  @override
  List<Object> get props => [];
}

class GetOrganizationsByOwnerEvent extends OrganizationEvent {
  final String ownerId;

  const GetOrganizationsByOwnerEvent(this.ownerId);

  @override
  List<Object> get props => [ownerId];
}

class GetOrganizationByIdEvent extends OrganizationEvent {
  final String organizationId;

  const GetOrganizationByIdEvent(this.organizationId);

  @override
  List<Object> get props => [organizationId];
}

class GetOrganizationsByListIdEvent extends OrganizationEvent {
  final List<String> organizationsId;

  const GetOrganizationsByListIdEvent(this.organizationsId);

  @override
  List<Object> get props => [organizationsId];
}

class AddOrganizationEvent extends OrganizationEvent {
  final Organization organization;

  const AddOrganizationEvent(this.organization);

  @override
  List<Object> get props => [organization];
}

class ResetOrganizationStateEvent extends OrganizationEvent {}