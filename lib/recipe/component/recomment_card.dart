import 'package:flutter/material.dart';

class ReCommentCard extends StatelessWidget {

  const ReCommentCard({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(left: 20),
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
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
