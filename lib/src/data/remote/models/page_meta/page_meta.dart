import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'page_meta.g.dart';

@JsonSerializable()
class PageMeta extends Equatable {
  const PageMeta({
    required this.page,
    required this.pageSize,
    required this.itemCount,
    required this.pageCount,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  final int page;
  final int pageSize;
  final int itemCount;
  final int pageCount;
  final bool hasPreviousPage;
  final bool hasNextPage;

  /// Connect the generated [_$PageMetaFromJson] function to the `fromJson`
  /// factory.
  factory PageMeta.fromJson(Map<String, dynamic> json) =>
      _$PageMetaFromJson(json);

  @override
  List<Object?> get props => [
        page,
        pageSize,
        itemCount,
        pageCount,
        hasPreviousPage,
        hasNextPage,
      ];
}
