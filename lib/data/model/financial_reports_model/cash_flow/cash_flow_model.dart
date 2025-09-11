import 'package:fin_assist/domain/entity/financial_report.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cash_flow_model.g.dart';

@JsonSerializable()
class CashFlowModel extends CashFlow {
  CashFlowModel({
    required super.operating,
    required super.investing,
    required super.financing,
  });

  factory CashFlowModel.fromJson(Map<String, dynamic> json) =>
      _$CashFlowModelFromJson(json);

  Map<String, dynamic> toJson() => _$CashFlowModelToJson(this);

  factory CashFlowModel.fromEntity(CashFlow entity) => CashFlowModel(
    operating: entity.operating,
    investing: entity.investing,
    financing: entity.financing,
  );

  CashFlow toEntity() => CashFlow(
    operating: operating,
    investing: investing,
    financing: financing,
  );
}
