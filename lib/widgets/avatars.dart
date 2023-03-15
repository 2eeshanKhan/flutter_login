import 'package:flutter/material.dart';

class Avatars extends StatelessWidget {
  const Avatars({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          yourStory(),
          for (var i = 0; i < 9; i++) avatar(number: i),
        ],
      ),
    );
  }

  GestureDetector yourStory() {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue,
                  backgroundImage: NetworkImage(
                      'https://thumbs.dreamstime.com/b/happy-smiling-geek-hipster-beard-man-cool-avatar-geek-man-avatar-104871313.jpg'),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 10,
                      child: Icon(Icons.add_circle_outline_rounded),
                    ))
              ],
            ),
            Text("Your Story")
          ],
        ),
      ),
    );
  }

  Padding avatar({int? number = 0}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue,
            backgroundImage: NetworkImage(
                'https://thumbs.dreamstime.com/b/happy-smiling-geek-hipster-beard-man-cool-avatar-geek-man-avatar-104871313.jpg'),
          ),
          Text("Username $number")
        ],
      ),
    );
  }
}
