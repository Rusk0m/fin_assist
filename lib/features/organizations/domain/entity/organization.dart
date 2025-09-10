import 'package:equatable/equatable.dart';

class Organization extends Equatable {
  final String organizationId;
  final String name;
  final String description;
  final String industry;
  final String inn;
  final String address;
  final String ownerId;

  const Organization({
    required this.organizationId,
    required this.name,
    required this.description,
    required this.industry,
    required this.inn,
    required this.address,
    required this.ownerId,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [organizationId,name,description,industry,inn,address,ownerId];
}
