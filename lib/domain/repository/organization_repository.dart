import '../entity/organization.dart';

abstract class OrganizationRepository {
  /// Получить организацию по ID
  Future<Organization?> getOrganizationById(String organizationId);

  /// Получить все организации пользователя (по ownerId)
  Future<List<Organization>> getOrganizationsByOwner(String ownerId);

  /// Добавить новую организацию
  Future<void> addOrganization(Organization organization);
}
