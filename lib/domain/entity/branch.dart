import 'package:equatable/equatable.dart';

class Branch extends Equatable{
  final String branchId;
  final String name;
  final String address;
  final String managerId;
  final String notes;
  final String organizationId;

  const Branch({
    required this.branchId,
    required this.name,
    required this.address,
    required this.managerId,
    required this.notes,
    required this.organizationId,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [branchId, name , address,managerId, notes, organizationId];
}
