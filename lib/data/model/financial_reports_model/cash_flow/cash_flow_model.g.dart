// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_flow_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashFlowModel _$CashFlowModelFromJson(Map<String, dynamic> json) =>
    CashFlowModel(
      operating: (json['operating'] as num).toDouble(),
      investing: (json['investing'] as num).toDouble(),
      financing: (json['financing'] as num).toDouble(),
    );

Map<String, dynamic> _$CashFlowModelToJson(CashFlowModel instance) =>
    <String, dynamic>{
      'operating': instance.operating,
      'investing': instance.investing,
      'financing': instance.financing,
    };
