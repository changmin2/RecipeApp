import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {

  const CommentCard({
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
                  '너무 맛있어요'
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'cm1'
                      ),
                      Text(
                        DateTime.now().toString()
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
