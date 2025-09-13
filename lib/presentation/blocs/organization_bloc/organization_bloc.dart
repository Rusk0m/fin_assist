import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fin_assist/domain/entity/organization.dart';
import 'package:fin_assist/domain/use_case/organization_use_case/add_organization_usecase.dart';
import 'package:fin_assist/domain/use_case/organization_use_case/get_organization_by_id_usecase.dart';
import 'package:fin_assist/domain/use_case/organization_use_case/get_organizations_by_owner_usecase.dart';
import 'package:get_it/get_it.dart';

part 'organization_event.dart';
part 'organization_state.dart';

class OrganizationBloc extends Bloc<OrganizationEvent, OrganizationState> {
  OrganizationBloc() : super(OrganizationInitial()) {
    on<GetOrganizationsByOwnerEvent>(_onGetOrganizationsByOwner);
    on<GetOrganizationByIdEvent>(_onGetOrganizationById);
    on<AddOrganizationEvent>(_onAddOrganization);
    on<ResetOrganizationStateEvent>(_onResetOrganizationState);
  }

  Future<void> _onGetOrganizationsByOwner(
      GetOrganizationsByOwnerEvent event,
      Emitter<OrganizationState> emit,
      ) async {
    emit(OrganizationLoading());
    try {
      final organizations = await GetIt.instance<GetOrganizationsByOwnerIdUseCase>().call(event.ownerId);
      emit(OrganizationsLoadedState(organizations!));
    } catch (e) {
      print('OrganizationBloc: Error loading organizations: $e');
      emit(OrganizationErrorState(e.toString()));
    }
  }

  Future<void> _onGetOrganizationById(
      GetOrganizationByIdEvent event,
      Emitter<OrganizationState> emit,
      ) async {
    emit(OrganizationLoading());
    try {
      final organization = await GetIt.instance<GetOrganizationByIdUseCase>().call(event.organizationId);

      if (organization != null) {
        emit(OrganizationLoadedState(organization));
      } else {
        emit(OrganizationNotFoundState());
      }
    } catch (e) {
      print('OrganizationBloc: Error loading organization: $e');
      emit(OrganizationErrorState(e.toString()));
    }
  }

  Future<void> _onAddOrganization(
      AddOrganizationEvent event,
      Emitter<OrganizationState> emit,
      ) async {
    emit(OrganizationLoading());
    try {
      await GetIt.instance<AddOrganizationUseCase>().call(event.organization);
      emit(OrganizationAddedState(event.organization));
    } catch (e) {
      print('OrganizationBloc: Error adding organization: $e');
      emit(OrganizationErrorState(e.toString()));
    }
  }

  void _onResetOrganizationState(
      ResetOrganizationStateEvent event,
      Emitter<OrganizationState> emit,
      ) {
    emit(OrganizationInitial());
  }
}