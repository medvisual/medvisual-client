// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageMeta _$PageMetaFromJson(Map<String, dynamic> json) => PageMeta(
      page: (json['page'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      itemCount: (json['itemCount'] as num).toInt(),
      pageCount: (json['pageCount'] as num).toInt(),
      hasPreviousPage: json['hasPreviousPage'] as bool,
      hasNextPage: json['hasNextPage'] as bool,
    );