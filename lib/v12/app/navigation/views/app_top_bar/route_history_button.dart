import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iroute/components/toly_ui/button/hover_icon_button.dart';

import '../../helper/router_history.dart';

class RouteHistoryButton extends StatefulWidget {
  const RouteHistoryButton({super.key});

  @override
  State<RouteHistoryButton> createState() => _RouteHistoryButtonState();
}

class _RouteHistoryButtonState extends State<RouteHistoryButton> {

  late RouterHistory _history ;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _history = RouterHistoryScope.of(context);
  }

  @override
  Widget build(BuildContext context) {
    bool hasHistory = _history.hasHistory;
    bool hasBackHistory = _history.hasBackHistory;
    Color activeColor = const Color(0xff9195AC);
    Color inActiveColor = const Color(0xffC7CAD5);
    Color historyColor = hasHistory?activeColor:inActiveColor;
    Color backHistoryColor = hasBackHistory?activeColor:inActiveColor;
    return Wrap(
      children: [
        HoverIconButton(
          size: 20,
          hoverColor: historyColor,
          defaultColor: historyColor,
          icon: CupertinoIcons.arrow_left_circle,
          onPressed: hasHistory?_history.back:null,
      ),
        const SizedBox(width: 8,),
        HoverIconButton(
          size: 20,
          hoverColor: backHistoryColor,
          defaultColor: backHistoryColor,
          icon: CupertinoIcons.arrow_right_circle,
          onPressed: hasBackHistory?_history.revocation:null,
        ),
      ],
    );
  }
}
