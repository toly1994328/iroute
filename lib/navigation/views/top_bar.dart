import 'package:flutter/material.dart';

import '../../components/components.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({super.key});

  @override
  Widget build(BuildContext context) {

    return DragToMoveWrap(
      child: const Row(
        children: [
          SizedBox(width: 20,),
          // Text(
          //   '404 界面丢失',
          //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          // ),
          Spacer(),
          WindowButtons()
        ],
      ),
    );
  }
}
