// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visual_disease_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisualDisease _$VisualDiseaseFromJson(Map<String, dynamic> json) =>
    VisualDisease(
      name: json['disease'] as String,
      advice: json['advice'] as String,
      probability: (json['probability'] as num).toDouble(),
      verdict: json['verdict'] as String,
    );

Map<String, dynamic> _$VisualDiseaseToJson(VisualDisease instance) =>
    <String, dynamic>{
      'disease': instance.name,
      'advice': instance.advice,
      'probability': instance.probability,
      'verdict': instance.verdict,
    };
