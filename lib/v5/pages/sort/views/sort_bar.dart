import 'package:flutter/material.dart';
import 'package:iroute/components/components.dart';

import '../provider/state.dart';
import '../functions.dart';
import 'sort_button.dart';

class SortBar extends StatelessWidget {
  const SortBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        const SortButton(),
        const SizedBox(width: 10,),
        DropSelectableWidget(
          fontSize: 12,
          data: sortNameMap.values.toList(),
          iconSize: 20,
          height: 28,
          width: 200,
          disableColor: const Color(0xff1F425F),
          onDropSelected: (int index) async {
            SortState state = SortStateScope.of(context);
            state.config =state.config.copyWith(
                name: sortNameMap.keys.toList()[index]
            );
            // curveAnim = CurvedAnimation(
            //     parent: _ctrl, curve: maps.values.toList()[index]);
            // _startAnim();
          },
        ),
        const SizedBox(width: 10,),
        GestureDetector(
            onTap: (){
              Scaffold.of(context).openEndDrawer();
              // showDialog(
              //     useRootNavigator: false,
              //     context: context, builder: (ctx)=>AlertDialog());
            },
            child: const Icon(Icons.settings))
      ],
    );
  }
}
