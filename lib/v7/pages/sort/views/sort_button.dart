import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../provider/state.dart';

class SortButton extends StatelessWidget {
  const SortButton({super.key});

  @override
  Widget build(BuildContext context) {
    SortState state = SortStateScope.of(context);
    VoidCallback? action;
    IconData icon;
    String text = '';
    Color color;
    switch (state.status) {
      case SortStatus.none:
        icon = Icons.not_started_outlined;
        color = Colors.green;
        action = state.sort;
        text = '点击启动';
        break;
      case SortStatus.sorting:
        icon = Icons.stop_circle_outlined;
        color = Colors.grey;
        action = null;
        text = '排序中...';
        break;
      case SortStatus.sorted:
        icon = CupertinoIcons.repeat;
        color = Colors.black;
        action = state.reset;
        text = '点击重置';
        break;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: action,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 18,
            ),
            const SizedBox(width: 4,),
            Text(text,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: color),),

          ],
        ),
      ),
    );
  }
}
