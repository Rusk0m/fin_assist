import 'package:fin_assist/features/financial_reports/domain/entity/financial_report.dart';
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

  IncomeStatement toEntity() =>
      IncomeStatement(revenue: revenue, cogs: cogs, netProfit: netProfit);
}
