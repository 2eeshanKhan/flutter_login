import 'package:flutter/material.dart';

import 'avatars.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        cardHeader(),
        cardImage(),
        cardIcons(),
        Container(
          padding: EdgeInsets.only(left: 8, right: 8, bottom: 5),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '17 Likes',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  CircleAvatar(
                      radius: 10,
                      backgroundImage: NetworkImage(
                          'https://thumbs.dreamstime.com/b/happy-smiling-geek-hipster-beard-man-cool-avatar-geek-man-avatar-104871313.jpg')),
                  Text(
                    'Username ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'In nature, nothing is perfect and everything is perfect.'),
                ],
              )
            ],
          ),
        )
      ],
    ));
  }

  Container cardIcons() {
    return Container(
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.chair_alt_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.send_outlined),
          ),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.bookmark_border),
          ),
        ],
      ),
    );
  }

  Container cardImage() {
    return Container(
      child: Image.network(
          'https://c7.alamy.com/comp/FM51Y3/landscape-naturebackground-wallpaper-FM51Y3.jpg'),
    );
  }

  Container cardHeader() {
    return Container(
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                    'https://thumbs.dreamstime.com/b/happy-smiling-geek-hipster-beard-man-cool-avatar-geek-man-avatar-104871313.jpg')),
            Text('Username'),
            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.menu))
          ],
        ));
  }
}
