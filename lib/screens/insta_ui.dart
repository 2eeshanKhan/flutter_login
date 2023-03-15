import 'package:flutter/material.dart';

import '../widgets/avatars.dart';
import '../widgets/my_card.dart';

class InstaApp extends StatelessWidget {
  const InstaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: InstaScreen(),
    );
  }
}

class InstaScreen extends StatelessWidget {
  const InstaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add_box_outlined,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Instagram',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.black,
                ))
          ],
        ),
        body: Container(
          child: ListView(children: [
            Avatars(),
            MyCard(),
            MyCard(),
            MyCard(),
            MyCard(),
            MyCard(),
            MyCard(),
            MyCard(),
            MyCard()
          ]),
        ));
  }
}
