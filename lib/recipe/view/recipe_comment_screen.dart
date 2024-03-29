import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:recipe_app/common/component/pagination_list_view.dart';
import 'package:recipe_app/common/layout/default_layout.dart';
import 'package:recipe_app/common/layout/default_layout_v2.dart';
import 'package:recipe_app/recipe/component/comment_card.dart';
import 'package:recipe_app/recipe/component/recomment_card.dart';
import 'package:recipe_app/recipe/model/comment_model.dart';
import 'package:recipe_app/recipe/model/recipe_detail_model.dart';
import 'package:recipe_app/recipe/provider/category_recipe_provider.dart';

import '../../common/component/pagination_list_viewV2.dart';
import '../../user/model/user_model.dart';
import '../../user/provider/user_me_provider.dart';
import '../provider/comment_provider.dart';

class RecipeCommentScreen extends ConsumerStatefulWidget {
  static get routeName => 'recipeComment';
  final int recipe_id;

  const RecipeCommentScreen({
    required this.recipe_id,
    Key? key
  }) : super(key: key);

  @override
  ConsumerState<RecipeCommentScreen> createState() => _RecipeCommentScreenState();
}

class _RecipeCommentScreenState extends ConsumerState<RecipeCommentScreen> {

  @override
  Widget build(BuildContext context) {
    //댓글이 추가 되었을 수도 있으므로 프로바이더 초기화
    ref.invalidate(commentProvider);
    final user = ref.read(userMeProvider) as UserModel;

    return DefaultLayoutV2(
      floatingActionButton: _floatingActionButton(context,ref,widget.recipe_id),
      appBar: _renderAppbar(context),
      child: PaginationListViewV2(
        provider: commentProvider(widget.recipe_id),
        itemBuilder: <CommentModel>(_, int index,comment) {
          return CommentCard(
            recipe_id:widget.recipe_id,
            comment_id: comment.comment_id,
            content: comment.content,
            creator: comment.creator,
            createDate: comment.createDate,
            username: user.username,
            recomments: comment.commentList,
          );
        }
        , recipe_id:widget.recipe_id ,
      )
    );
  }
}
AppBar _renderAppbar(BuildContext context){
  return AppBar(
    backgroundColor: Colors.white,
    title: Text(
      '댓 글',
      style: TextStyle(
          color: Colors.brown,
          fontWeight: FontWeight.w700
      ),
    ),
    centerTitle: true,
    leading: IconButton(
        onPressed: (){Navigator.pop(context);},
        icon: Icon(Icons.arrow_back),
        color: Colors.brown,
        alignment: Alignment.centerLeft,
      )
  );
}

FloatingActionButton _floatingActionButton(BuildContext context,WidgetRef ref,int recipe_id){
  final _formKey = GlobalKey<FormState>();
  var _comment;
  return FloatingActionButton.extended(
      backgroundColor: Colors.green,
      onPressed: (){
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context){
              final bottomInset = MediaQuery.of(context).viewInsets.bottom;
              return Padding(
                  padding: EdgeInsets.only(bottom: bottomInset),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          onSaved: (value){
                            _comment = value as String;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '댓글을 입력해주세요'
                          ),
                          validator: (value){
                            if(value!.length<1){
                              return "댓글을 입력해주세요";
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: (){
                              _formKey.currentState!.save();
                              if(_formKey.currentState!.validate()){
                                final state = ref.watch(userMeProvider);
                                final pState = state as UserModel;

                                ref.watch(commentProvider(recipe_id).notifier).createComment(pState.username,_comment);
                                final detailState = ref.watch(categoryDetailProvider(recipe_id));
                                if(detailState is RecipeDetailModel){
                                  detailState.commentCount = detailState.commentCount+1;
                                };

                                Navigator.pop(context);
                              }
                            },
                            child: Text('등록'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Text('취소'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown
                            ),
                          )
                        ],
                      )
                    ],
                  ),
              );
            }
        );
      },
      label: Text(
        "댓글작성"
      ),
      icon: Icon(
        Icons.edit,
      ),
  );
}
