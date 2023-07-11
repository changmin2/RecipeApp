import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable()
class PaginationParams{
  final int? after;
  final int? count;
  final String? keyword;
  final String? nm;
  final String? level;

  const PaginationParams({
    this.after,
    this.count,
    this.keyword,
    this.nm,
    this.level
  });

  PaginationParams copyWith({
    int? after,
    int? count,
    String? keyword,
    String? nm,
    String? level
  }){
    return PaginationParams(
        after: after ?? this.after,
        count: count ?? this.count,
        keyword: keyword ?? this.keyword,
        nm: nm ?? this.nm,
        level: level ?? this.level
    );
  }

  factory PaginationParams.fromJson(Map<String,dynamic> json)
  => _$PaginationParamsFromJson(json);

  Map<String,dynamic> toJson() => _$PaginationParamsToJson(this);
}