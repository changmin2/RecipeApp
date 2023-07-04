import 'package:flutter/cupertino.dart';

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