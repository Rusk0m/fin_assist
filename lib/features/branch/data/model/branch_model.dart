import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/branch.dart';

part 'branch_model.g.dart';

@JsonSerializable()
class BranchModel extends Branch {
  BranchModel({
    required super.branchId,
    required super.name,
    required super.address,
    required super.managerId,
    required super.notes,
    required super.createdAt,
    required super.organizationId,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);

  Map<String, dynamic> toJson() => _$BranchModelToJson(this);

  Branch toEntity() => Branch(
    branchId: branchId,
    name: name,
    address: address,
    managerId: managerId,
    notes: notes,
    createdAt: createdAt,
    organizationId: organizationId,
  );
}
