// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationModel _$OrganizationModelFromJson(Map<String, dynamic> json) =>
    OrganizationModel(
      organizationId: json['organizationId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      industry: json['industry'] as String,
      inn: json['inn'] as String,
      address: json['address'] as String,
      ownerId: json['ownerId'] as String,
    );

Map<String, dynamic> _$OrganizationModelToJson(OrganizationModel instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'name': instance.name,
      'description': instance.description,
      'industry': instance.industry,
      'inn': instance.inn,
      'address': instance.address,
      'ownerId': instance.ownerId,
    };
