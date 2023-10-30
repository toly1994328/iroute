import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iroute/components/toly_ui/button/hover_icon_button.dart';
import '../../router/app_router_delegate.dart';

class RouteHistoryButton extends StatefulWidget {
  const RouteHistoryButton({super.key});

  @override
  State<RouteHistoryButton> createState() => _RouteHistoryButtonState();
}

class _RouteHistoryButtonState extends State<RouteHistoryButton> {
  @override
  void initState() {
    super.initState();
    router.addListener(_onChange);
  }

  @override
  void dispose() {
    router.removeListener(_onChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool hasHistory = router.hasHistory;
    bool hasBackHistory = router.hasBackHistory;
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
          onPressed: hasHistory?router.back:null,
      ),
        const SizedBox(width: 8,),
        HoverIconButton(
          size: 20,
          hoverColor: backHistoryColor,
          defaultColor: backHistoryColor,
          icon: CupertinoIcons.arrow_right_circle,
          onPressed: hasBackHistory?router.revocation:null,
        ),
      ],
    );
  }

  void _onChange() {
    setState(() {});
  }
}
