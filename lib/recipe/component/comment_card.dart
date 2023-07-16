import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  final String content;
  final String creator;
  final DateTime createDate;

  const CommentCard({
    required this.content,
    required this.creator,
    required this.createDate,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                title: Text(
                  content
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        creator
                      ),
                      Text(
                        DateFormat('yy/MM/dd HH:mm').format(createDate)
                      ),
                    ],
                  ),
                ),
                trailing: _PopupMenuButtonPage(context)
                )
    );
  }
}



PopupMenuButton _PopupMenuButtonPage (BuildContext context){
    return PopupMenuButton(
      onSelected: (value){
        print(value);
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
          )
        ];
      },
    );
}
