import 'package:flutter/material.dart';
import '../app_router_delegate.dart';
class RouteBackIndicator extends StatefulWidget {
  const RouteBackIndicator({super.key});

  @override
  State<RouteBackIndicator> createState() => _RouteBackIndicatorState();
}

class _RouteBackIndicatorState extends State<RouteBackIndicator> {

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
    if(router.canPop){
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: router.backStack,
          child: Container(
              width: 26,
              height: 26,
              margin: EdgeInsets.only(right: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xffE3E5E7),
                borderRadius: BorderRadius.circular(6)
              ),
              child: Icon(Icons.arrow_back_ios_new,size: 14,)),
        ),
      );
    }
    return SizedBox();
  }

  void _onChange() {
    setState(() {

    });
  }
}
