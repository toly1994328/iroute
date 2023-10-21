import 'package:flutter/material.dart';
import '../router/app_router_delegate.dart';
import 'package:window_manager/window_manager.dart';

import '../../../components/tolyui/navigation/toly_breadcrumb.dart';
import '../../../components/windows/window_buttons.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DragToMoveAreaNoDouble(
      child: Container(
        alignment: Alignment.center,
        height: 46,
        child: Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            RouterIndicator(),
            Spacer(),
            WindowButtons()
          ],
        ),
      ),
    );
  }
}

class RouterIndicator extends StatefulWidget {
  const RouterIndicator({super.key});

  @override
  State<RouterIndicator> createState() => _RouterIndicatorState();
}

class _RouterIndicatorState extends State<RouterIndicator> {
  @override
  void initState() {
    super.initState();
    router.addListener(_onRouterChange);
  }

  Map<String, String> routeLabelMap = {
    '/color': '颜色板',
    '/color/add': '添加颜色',
    '/color/detail': '颜色详情',
    '/counter': '计数器',
    '/user': '我的',
    '/settings': '系统设置',
  };

  @override
  Widget build(BuildContext context) {
    return TolyBreadcrumb(
      items: pathToBreadcrumbItems(router.path),
      onTapItem: (item){
        if(item.to!=null){
          router.path = item.to!;
        }
      },
    );
  }

  void _onRouterChange() {
    print('_onRouterChange');
    setState(() {});
  }

  List<BreadcrumbItem> pathToBreadcrumbItems(String path) {
    Uri uri = Uri.parse(path);
    List<BreadcrumbItem> result = [];
    String to = '';

    String distPath = '';
    for (String segment in uri.pathSegments) {
      distPath += '/$segment';
    }

    for (String segment in uri.pathSegments) {
      to += '/$segment';
      result.add(BreadcrumbItem(to: to, label: routeLabelMap[to] ?? '未知路由',active: to==distPath));
    }
    return result;
  }
}

class DragToMoveAreaNoDouble extends StatelessWidget {
  final Widget child;

  const DragToMoveAreaNoDouble({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (details) {
        windowManager.startDragging();
      },
      child: child,
    );
  }
}
