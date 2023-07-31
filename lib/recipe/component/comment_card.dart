import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:recipe_app/recipe/component/recomment_card.dart';
import 'package:recipe_app/recipe/provider/comment_provider.dart';
import 'package:recipe_app/recipe/repository/comment_repository.dart';

import '../../user/model/user_model.dart';
import '../../user/provider/user_me_provider.dart';
import '../model/comment_model.dart';

class CommentCard extends ConsumerWidget {
  final int recipe_id;
  final int comment_id;
  final String content;
  //댓글 작성자
  final String creator;
  final DateTime createDate;
  //로그인 한 유저 이름
  final String? username;
  //대댓글 리스트
  final List<Recomment>? recomments;


  const CommentCard({
    required this.recipe_id,
    required this.comment_id,
    required this.content,
    required this.creator,
    required this.createDate,
    this.username ="",
    this.recomments,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Column(
      children: [
          Card(
              child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: FittedBox(
                      child: Icon(
                        Icons.create,
                        color: Colors.brown,
                      )
                    ),
                    backgroundColor: Colors.white10,
                  ),
                  title: Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      content
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 90,
                          child: Text(
                            creator,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 80,
                          child: Column(
                            children: [
                              Text(
                                  DateFormat('yy/MM/dd HH:mm').format(createDate).split(" ")[0]
                              ),
                              Text(
                                  DateFormat('yy/MM/dd HH:mm').format(createDate).split(" ")[1]
                              ),
                            ],

                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: (creator == username || username == 'superadmin1') ? //삭제, 수정 권한 부여 -> 작성자와 현재 로그인한 유저 아이디가 같음녀 권한부여
                  _PopupMenuButtonPage(context,ref,comment_id,recipe_id)
                  : _NoCreatorPopupMenuButtonPage(context,ref,comment_id,recipe_id)
              )
        ),
        recomments?.length != 0 ?
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: recomments!.length,
              itemBuilder: (BuildContext context,int index){
                return ReCommentCard(
                  recomment: recomments![index],
                  username: username!,
                  comment_id: comment_id,
                );
              }): Container()
        //대댓글 자리
      ]
    );
  }
}



PopupMenuButton _PopupMenuButtonPage (BuildContext context,WidgetRef ref,int comment_id,int recipe_id){
    return PopupMenuButton(
      onSelected: (value){
        if(value=='삭제'){
          ref.read(commentProvider(recipe_id).notifier).deleteComment(comment_id);
        }else if(value=='신고'){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('신고되었습니다. 누적된 신고자는 블라인드 처리 됩니다.'),
                duration: Duration(seconds: 1),
              )
          );
        }else  if(value=='대댓글'){
          final _formKey = GlobalKey<FormState>();
          var _comment;
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
                                ref.read(commentProvider(recipe_id).notifier).createRecommend(pState.username,_comment, comment_id);
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

        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: '대댓글',
            child: Text('대댓글'),
          ),
          PopupMenuItem(
            value: '신고',
            child: Text('신고'),
          ),
          PopupMenuItem(
            value: '삭제',
            child: Text('삭제'),
          )
        ];
      },
    );
}


PopupMenuButton _NoCreatorPopupMenuButtonPage (BuildContext context,WidgetRef ref,int comment_id,int recipe_id){
  return PopupMenuButton(
    onSelected: (value){
      if(value=='대댓글'){
        final _formKey = GlobalKey<FormState>();
        var _comment;
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
                              ref.read(commentProvider(recipe_id).notifier).createRecommend(pState.username,_comment, comment_id);
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

      }
      else if(value=='신고'){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('신고되었습니다. 누적된 신고자는 블라인드 처리 됩니다.'),
            duration: Duration(seconds: 1),
          )
        );
      }
    },
    itemBuilder: (context) {
      return [
        PopupMenuItem(
          value: '대댓글',
          child: Text('대댓글'),
        ),
        PopupMenuItem(
          value: '신고',
          child: Text('신고'),
        ),
      ];
    },
  );
}