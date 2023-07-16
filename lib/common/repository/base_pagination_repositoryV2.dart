import 'package:recipe_app/common/model/cursor_pagination_model.dart';
import 'package:recipe_app/common/model/model_with_id.dart';
import 'package:recipe_app/common/model/pagination_params.dart';

import '../../recipe/model/comment_model.dart';
import '../model/model_with_idV2.dart';

abstract class IBasePaginationRepositoryV2<T extends IModelWithIdV2>{
  Future<CursorPagination<T>> commentPaginate({
    required int recipe_id,
    PaginationParams? paginationParams = const PaginationParams(),
  });
}