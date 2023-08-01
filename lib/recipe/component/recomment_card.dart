import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../model/comment_model.dart';
import '../provider/comment_provider.dart';

class ReCommentCard extends ConsumerWidget {

  final Recomment recomment;
  final String username;
  final int comment_id;
  final int recipe_id;

  const ReCommentCard({
    required this.recomment,
    required this.username,
    required this.comment_id,
    required this.recipe_id,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Card(
          child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: FittedBox(
                    child: Icon(
                      Icons.trending_flat,
                      color: Colors.brown,
                    )
                ),
                backgroundColor: Colors.white10,

              ),
              title: Text(
                  recomment.content
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        recomment.creator
                    ),
                    Container(
                      width: 80,
                      child: Column(
                        children: [
                          Text(
                              DateFormat('yy/MM/dd HH:mm').format(recomment.createDate).split(" ")[0]
                          ),
                          Text(
                              DateFormat('yy/MM/dd HH:mm').format(recomment.createDate).split(" ")[1]
                          ),
                        ],

                      ),
                    )
                  ],
                ),
              ),
              trailing: (recomment.creator == username || username == 'superadmin1') ? //삭제, 수정 권한 부여 -> 작성자와 현재 로그인한 유저 아이디가 같음녀 권한부여
              _PopupMenuButtonPage(context,ref,recipe_id,recomment.recomment_id,comment_id)
                  : _NoCreatorPopupMenuButtonPage(context,ref)
          ),

      ),
    );
  }
}


PopupMenuButton _PopupMenuButtonPage (BuildContext context,WidgetRef ref,int recipe_id,int recomment_id,int commnet_id){
  return PopupMenuButton(
    onSelected: (value){
      if(value=='신고') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('신고되었습니다. 누적된 신고자는 블라인드 처리 됩니다.'),
              duration: Duration(seconds: 1),
            )
        );
      }else if(value == '삭제'){
        ref.read(commentProvider(recipe_id).notifier).deleteReComment(recomment_id,commnet_id);
      }
    },
    itemBuilder: (context) {
      return [
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


PopupMenuButton _NoCreatorPopupMenuButtonPage (BuildContext context,WidgetRef ref){
  return PopupMenuButton(
    onSelected: (value){
    },
    itemBuilder: (context) {
      return [
        PopupMenuItem(
          value: '신고',
          child: Text('신고'),
        ),
      ];
    },
  );
}
