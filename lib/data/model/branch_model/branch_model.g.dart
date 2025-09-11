// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchModel _$BranchModelFromJson(Map<String, dynamic> json) => BranchModel(
  branchId: json['branchId'] as String,
  name: json['name'] as String,
  address: json['address'] as String,
  managerId: json['managerId'] as String,
  notes: json['notes'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  organizationId: json['organizationId'] as String,
);

Map<String, dynamic> _$BranchModelToJson(BranchModel instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'name': instance.name,
      'address': instance.address,
      'managerId': instance.managerId,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'organizationId': instance.organizationId,
    };
