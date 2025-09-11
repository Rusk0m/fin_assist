import 'package:fin_assist/domain/entity/financial_report.dart';
import 'package:json_annotation/json_annotation.dart';

part 'income_statement_model.g.dart';

@JsonSerializable()
class IncomeStatementModel extends IncomeStatement {
  IncomeStatementModel({
    required super.revenue,
    required super.cogs,
    required super.netProfit,
  });

  factory IncomeStatementModel.fromJson(Map<String, dynamic> json) =>
      _$IncomeStatementModelFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeStatementModelToJson(this);

  factory IncomeStatementModel.fromEntity(IncomeStatement entity) =>
      IncomeStatementModel(
        revenue: entity.revenue,
        cogs: entity.cogs,
        netProfit: entity.netProfit,
      );

  IncomeStatement toEntity() =>
      IncomeStatement(revenue: revenue, cogs: cogs, netProfit: netProfit);
}
