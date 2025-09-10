import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_assist/features/organizations/domain/repository/organization.dart';
import '../../domain/entity/organization.dart';
import '../model/organization_model.dart';

class OrganizationRepositoryImpl implements OrganizationRepository {
  final FirebaseFirestore firestore;

  OrganizationRepositoryImpl(this.firestore);

  @override
  Future<void> addOrganization(Organization organization) async {
    final docRef = firestore.collection('organizations').doc(organization.organizationId);
    await docRef.set(OrganizationModel(
      organizationId: organization.organizationId,
      name: organization.name,
      description: organization.description,
      industry: organization.industry,
      inn: organization.inn,
      address: organization.address,
      ownerId: organization.ownerId,
    ).toJson());
  }

  @override
  Future<Organization?> getOrganizationById(String organizationId) async {
    final doc = await firestore.collection('organizations').doc(organizationId).get();
    if (!doc.exists) return null;
    return OrganizationModel.fromJson(doc.data()!).toEntity();
  }

  @override
  Future<List<Organization>> getOrganizationsByOwner(String ownerId) async {
    final query = await firestore.collection('organizations')
        .where('ownerId', isEqualTo: ownerId)
        .get();
    return query.docs.map((doc) => OrganizationModel.fromJson(doc.data()).toEntity()).toList();
  }
}
