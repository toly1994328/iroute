import 'package:flutter/material.dart';
import 'package:iroute/components/components.dart';
import '../router/app_router_delegate.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DragToMoveWrap(
      child: Container(
        alignment: Alignment.center,
        height: 46,
        child: const Row(
          children: [
            Expanded(child: SizedBox()),
            WindowButtons()
          ],
        ),
      ),
    );
  }
}

