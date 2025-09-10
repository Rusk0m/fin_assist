// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_statement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncomeStatementModel _$IncomeStatementModelFromJson(
  Map<String, dynamic> json,
) => IncomeStatementModel(
  revenue: (json['revenue'] as num).toDouble(),
  cogs: (json['cogs'] as num).toDouble(),
  netProfit: (json['netProfit'] as num).toDouble(),
);

Map<String, dynamic> _$IncomeStatementModelToJson(
  IncomeStatementModel instance,
) => <String, dynamic>{
  'revenue': instance.revenue,
  'cogs': instance.cogs,
  'netProfit': instance.netProfit,
};
