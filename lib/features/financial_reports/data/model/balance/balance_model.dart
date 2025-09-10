import 'package:fin_assist/features/financial_reports/domain/entity/financial_report.dart';
import 'package:json_annotation/json_annotation.dart';

part 'balance_model.g.dart';

@JsonSerializable()
class BalanceModel extends Balance {
  BalanceModel({
    required super.cash,
    required super.currentAssets,
    required super.nonCurrentAssets,
    required super.inventory,
    required super.receivables,
    required super.totalAssets,
    required super.equity,
    required super.shortTermLiabilities,
    required super.longTermLiabilities,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) =>
      _$BalanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceModelToJson(this);

  Balance toEntity() => Balance(
    cash: cash,
    currentAssets: currentAssets,
    nonCurrentAssets: nonCurrentAssets,
    inventory: inventory,
    receivables: receivables,
    totalAssets: totalAssets,
    equity: equity,
    shortTermLiabilities: shortTermLiabilities,
    longTermLiabilities: longTermLiabilities,
  );
}
