import 'package:flutter/material.dart';

class TitleGroup extends StatelessWidget {
  final String title;
  const TitleGroup({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            CircleAvatar(
              radius: 6,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
