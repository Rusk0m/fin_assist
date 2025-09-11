import 'package:fin_assist/domain/entity/organization.dart';
import 'package:fin_assist/domain/repository/organization_repository.dart';

class GetOrganizationsByOwnerIdUseCase {
  final OrganizationRepository organizationRepository;

  GetOrganizationsByOwnerIdUseCase(this.organizationRepository);

  Future<List<Organization>?> call(String ownerId) async {
    try {
      return organizationRepository.getOrganizationsByOwner(ownerId);
    } catch (e) {
      print(ArgumentError(e.toString()));
    }
  }
}
