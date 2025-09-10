import 'package:fin_assist/features/financial_reports/domain/entity/financial_report.dart';
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

  CashFlow toEntity() => CashFlow(operating: operating, investing: investing, financing: financing);
}
