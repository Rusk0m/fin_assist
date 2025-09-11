import 'package:fin_assist/domain/entity/organization.dart';
import 'package:fin_assist/domain/repository/organization_repository.dart';

class GetOrganizationByIdUseCase {
  final OrganizationRepository organizationRepository;

  GetOrganizationByIdUseCase(this.organizationRepository);

  Future<Organization?> call(String organizationId) async {
    try {
      return organizationRepository.getOrganizationById(organizationId);
    } catch (e) {
      print(ArgumentError(e.toString()));
    }
  }
}
