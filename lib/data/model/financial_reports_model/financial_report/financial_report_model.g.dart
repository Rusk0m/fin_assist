// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinancialReportModel _$FinancialReportModelFromJson(
  Map<String, dynamic> json,
) => FinancialReportModel(
  reportId: json['reportId'] as String,
  branchId: json['branchId'] as String,
  organizationId: json['organizationId'] as String,
  period: json['period'] as String,
  type: json['type'] as String,
  status: json['status'] as String,
  submittedBy: json['submittedBy'] as String,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
  submittedAt: const TimestampConverter().fromJson(
    json['submittedAt'] as Timestamp,
  ),
  balance: BalanceModel.fromJson(json['balance'] as Map<String, dynamic>),
  cashFlow: CashFlowModel.fromJson(json['cashFlow'] as Map<String, dynamic>),
  incomeStatement: IncomeStatementModel.fromJson(
    json['incomeStatement'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$FinancialReportModelToJson(
  FinancialReportModel instance,
) => <String, dynamic>{
  'reportId': instance.reportId,
  'branchId': instance.branchId,
  'period': instance.period,
  'organizationId': instance.organizationId,
  'type': instance.type,
  'status': instance.status,
  'submittedBy': instance.submittedBy,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'submittedAt': const TimestampConverter().toJson(instance.submittedAt),
  'balance': instance.balance.toJson(),
  'cashFlow': instance.cashFlow.toJson(),
  'incomeStatement': instance.incomeStatement.toJson(),
};
