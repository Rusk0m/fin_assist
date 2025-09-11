import 'package:fin_assist/domain/entity/organization.dart';
import 'package:fin_assist/domain/repository/organization_repository.dart';

class AddOrganizationUseCase {
  final OrganizationRepository organizationRepository;

  AddOrganizationUseCase(this.organizationRepository);

  Future<void> call(Organization organization) async {
    try {
      organizationRepository.addOrganization(organization);
    } catch (e) {
      print(ArgumentError(e.toString()));
    }
  }
}
