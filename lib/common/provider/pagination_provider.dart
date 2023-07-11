import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/cursor_pagination_model.dart';
import '../model/model_with_id.dart';
import '../model/pagination_params.dart';
import '../repository/base_pagination_repository.dart';

class PaginationProvider<T extends IModelWithId,U extends IBasePaginationRepository<T>> extends StateNotifier<CursorPaginationBase>{
  final U repository;
  String? keyword;
  String? nm;
  String? level;
  PaginationProvider({
    required this.repository,
    this.keyword="",
    this.nm="",
    this.level=""
  }): super(CursorPaginationLoading()){
    paginate(keyword: keyword!,nm: nm!,level: level!);
  }
  //상추 치커리 오징어 초침무
  Future<void> paginate({
    int fetchCount = 20,
    //추가로 데이터 더 가져오기(true)
    //flase - 새로고침 첫 데이터, 데이터가 있는 상태에서
    bool fetchMore = false,
    // 강제로 다시 로딩하기
    // true - CursorPaginationLoading(), 데이터를 다 지우고 로딩부터 시작, 완전히 새로고침
    bool forceRefetch = false,
    //검색어
    String keyword ="",
    //종류
    String nm="",
    //난이도
    String level=""
  }) async{
    try{
      // 5가지 가능성
      // State의 상태
      // [상태가]
      // 1) CursorPagination - 정상적으로 데이터가 있는 상태
      // 2) CursorPaginationLoading - 데이터가 로딩중인 상태 (현재 캐시 없음)
      // 3) CursorPaginationError - 에러가 있는 상태
      // 4) CursorPaginationRefetching - 첫번째 페이지부터 다시 데이터 가져올때
      // 5) CursorPaginationFetchMore - 추가 데이터를 paginate 해오라는 요청을 받았을 때

      // 바로 반환하는 상황
      // 1) hasMore = false (기존 상태에서 이미 다음 데이터가 없다는 값을 들고있다면)
      // 2) 로딩중 - fetchMore : true
      //    fetchMore가 아닐때 - 새로고침의 의도가 있다
      if(state is CursorPagination && !forceRefetch){
        final pState = state as CursorPagination;

        if(!pState.meta.hasMore){
          //더 데이터가 없다
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      //2번 상황, 로딩 중일 때 또 데이터를 요청하는걸 방지
      if(fetchMore && (isLoading || isRefetching || isFetchingMore)){
        return;
      }

      // PaginationParams 생성
      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
        keyword: this.keyword,
        nm:  this.nm,
        level: this.level
      );

      //fetchMore
      //데이터를 추가로 더 가져오는 상황
      if(fetchMore){
        final pState = state as CursorPagination<T>;

        state = CursorPaginationFetchingMore(
            data: pState.data,
            meta: pState.meta
        );
        print(this.keyword.toString()+"키워드");
        paginationParams = paginationParams.copyWith(
            after: pState.data.last.recipe_id,
            keyword: this.keyword,
            level: this.level,
            nm: this.nm
        );
      }
      //데이터를 처음부터 가져오는 상황
      else{
        // 만약에 데이터가 있는 상황이라면
        // 기존 데이터를 보존한채로 Fetch (API 요청)를 진행
        if(state is CursorPagination && !forceRefetch){
          final pState = state as CursorPagination<T>;

          state = CursorPaginationRefetching<T>(
              data: pState.data,
              meta: pState.meta
          );
        }
        //나머지 상황 데이터를 유지하지 않아도됨
        else{
          state = CursorPaginationLoading();
        }
      }

      final resp = await repository.paginate(
          paginationParams: paginationParams
      );


      if(state is CursorPaginationFetchingMore){
        final pState = state as CursorPaginationFetchingMore<T>;

        //기존 데이터에 새로운 데이터 추가
        state = resp.copyWith(
            data: [
              ...pState.data,
              ...resp.data,
            ]
        );
      } else{
        state = resp;
      }
    }catch(e){
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }


}