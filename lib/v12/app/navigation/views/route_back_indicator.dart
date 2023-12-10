import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteBackIndicator extends StatefulWidget {
  const RouteBackIndicator({super.key});

  @override
  State<RouteBackIndicator> createState() => _RouteBackIndicatorState();
}

class _RouteBackIndicatorState extends State<RouteBackIndicator> {

  late GoRouterDelegate _delegate ;

  @override
  void initState() {
    super.initState();
    _delegate =  GoRouter.of(context).routerDelegate;
    _delegate.addListener(_onChange);
  }

  @override
  void dispose() {
    _delegate.removeListener(_onChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool hasPush = _delegate.currentConfiguration.matches
        .whereType<ImperativeRouteMatch>().isNotEmpty;
    if(hasPush){
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: context.pop,
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
