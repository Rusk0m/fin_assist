// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchModel _$BranchModelFromJson(Map<String, dynamic> json) => BranchModel(
  branchId: json['branchId'],
  name: json['name'],
  address: json['address'],
  managerId: json['managerId'],
  notes: json['notes'],
  createdAt: json['createdAt'],
  organizationId: json['organizationId'],
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
