import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/organization.dart';

part 'organization_model.g.dart';

@JsonSerializable()
class OrganizationModel extends Organization {
  const OrganizationModel({
    required super.organizationId,
    required super.name,
    required super.description,
    required super.industry,
    required super.inn,
    required super.address,
    required super.ownerId,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      _$OrganizationModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationModelToJson(this);

  Organization toEntity() => Organization(
    organizationId: organizationId,
    name: name,
    description: description,
    industry: industry,
    inn: inn,
    address: address,
    ownerId: ownerId,
  );
}
