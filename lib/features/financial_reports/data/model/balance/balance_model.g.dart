// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceModel _$BalanceModelFromJson(Map<String, dynamic> json) => BalanceModel(
  cash: (json['cash'] as num).toDouble(),
  currentAssets: (json['currentAssets'] as num).toDouble(),
  nonCurrentAssets: (json['nonCurrentAssets'] as num).toDouble(),
  inventory: (json['inventory'] as num).toDouble(),
  receivables: (json['receivables'] as num).toDouble(),
  totalAssets: (json['totalAssets'] as num).toDouble(),
  equity: (json['equity'] as num).toDouble(),
  shortTermLiabilities: (json['shortTermLiabilities'] as num).toDouble(),
  longTermLiabilities: (json['longTermLiabilities'] as num).toDouble(),
);

Map<String, dynamic> _$BalanceModelToJson(BalanceModel instance) =>
    <String, dynamic>{
      'cash': instance.cash,
      'currentAssets': instance.currentAssets,
      'nonCurrentAssets': instance.nonCurrentAssets,
      'inventory': instance.inventory,
      'receivables': instance.receivables,
      'totalAssets': instance.totalAssets,
      'equity': instance.equity,
      'shortTermLiabilities': instance.shortTermLiabilities,
      'longTermLiabilities': instance.longTermLiabilities,
    };
