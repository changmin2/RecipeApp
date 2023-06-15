import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

abstract class CursorPaginationBase{}

class CursorPaginationError extends CursorPaginationBase{
  final String message;

  CursorPaginationError({
    required this.message
  });
}

class CursorPaginationLoading extends CursorPaginationBase{}

@JsonSerializable(
  //제네릭을 사용하는 클래스에서 fromJson 및 toJson에 대해 추가 도우미 매개변수 생성
  genericArgumentFactories: true
)
class CursorPagination<T> extends CursorPaginationBase{
  final CursorPaginationMeta meta;
  final List<T> data;

  CursorPagination({
    required this.meta,
    required this.data
  });
  CursorPagination copyWith({
    CursorPaginationMeta? meta,
    List<T>? data
  }){
    return CursorPagination<T>(
        meta: meta ?? this.meta,
        data: data ?? this.data
    );
  }

  factory CursorPagination.fromJson(Map<String,dynamic> json, T Function(Object? json) fromJsonT)=>
      _$CursorPaginationFromJson(json,fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta{
  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore
  });

  CursorPaginationMeta copyWith({
    int? count,
    bool? hasMore
  }){
    return CursorPaginationMeta(count: count ?? this.count, hasMore: hasMore ?? this.hasMore);
  }

  factory CursorPaginationMeta.fromJson(Map<String,dynamic> json)=>
      _$CursorPaginationMetaFromJson(json);

}

class CursorPaginationRefetching<T> extends CursorPagination<T>{
  CursorPaginationRefetching({
    required super.data,
    required super.meta
  });
}

class CursorPaginationFetchingMore<T> extends CursorPagination<T>{
  CursorPaginationFetchingMore({
    required super.data,
    required super.meta
  });
}