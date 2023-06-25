import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable()
class PaginationParams{
  final int? after;
  final int? count;
  final String? keyword;

  const PaginationParams({
    this.after,
    this.count,
    this.keyword
  });

  PaginationParams copyWith({
    int? after,
    int? count,
    String? keyword,
  }){
    return PaginationParams(
        after: after ?? this.after,
        count: count ?? this.count,
        keyword: keyword ?? this.keyword
    );
  }

  factory PaginationParams.fromJson(Map<String,dynamic> json)
  => _$PaginationParamsFromJson(json);

  Map<String,dynamic> toJson() => _$PaginationParamsToJson(this);
}