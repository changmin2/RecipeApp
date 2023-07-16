import 'package:flutter/cupertino.dart';
import 'package:recipe_app/common/provider/comment_pagination_provider.dart';

import '../provider/clip_pagination_provider.dart';
import '../provider/pagination_provider.dart';

class PaginationUtils{
  static void paginate({
    required ScrollController controller,
    required PaginationProvider provider,
  }){
    if(controller.offset > controller.position.maxScrollExtent - 300){
      provider.paginate(
        fetchMore: true,
      );
    }
  }
}

class PaginationUtilsV2{
  static void paginate({
    required ScrollController controller,
    required CommentPaginationProvider provider,
    required int recipe_id,
  }){
    if(controller.offset > controller.position.maxScrollExtent - 300){
      provider.paginate(
        fetchMore: true, recipe_id: recipe_id
      );
    }
  }
}

class ClipPaginationUtils{
  static void paginate({
    required ScrollController controller,
    required ClipPaginationProvider provider,
  }){
    if(controller.offset > controller.position.maxScrollExtent - 150){
      provider.paginate(
        fetchMore: true,
      );
    }
  }
}