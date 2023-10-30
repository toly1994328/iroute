import 'package:flutter/material.dart';
import 'package:iroute/components/components.dart';
import '../../router/app_router_delegate.dart';
import 'app_router_editor.dart';
import 'history_view_icon.dart';
import 'route_history_button.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DragToMoveWrap(
      child: Container(
        alignment: Alignment.center,
        height: 46,
        child: Row(
          children: [
            const SizedBox(width: 16),
            const RouterIndicator(),
            Expanded(
                child: Row(children: [
              const Spacer(),
                  RouteHistoryButton(),
              const SizedBox(width: 12,),
              SizedBox(
                  width: 250,
                  child: AppRouterEditor(
                    onSubmit: (path) => router.changePath(path),
                  )),
                  const SizedBox(width: 12,),
                  HistoryViewIcon(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: VerticalDivider(
                  width: 32,
                ),
              )
            ])),
            const WindowButtons()
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

Map<String, String> kRouteLabelMap = {
  '/color': '颜色板',
  '/color/add': '添加颜色',
  '/color/detail': '颜色详情',
  '/counter': '计数器',
  '/user': '我的',
  '/settings': '系统设置',
};

class _RouterIndicatorState extends State<RouterIndicator> {
  @override
  void initState() {
    super.initState();
    router.addListener(_onRouterChange);
  }

  @override
  void dispose() {
    router.removeListener(_onRouterChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TolyBreadcrumb(
      items: pathToBreadcrumbItems(router.path),
      onTapItem: (item) {
        if (item.to != null) {
          router.changePath(item.to!);
        }
      },
    );
  }

  void _onRouterChange() {
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
      String label = kRouteLabelMap[to] ?? '未知路由';
      result.add(BreadcrumbItem(to: to, label: label, active: to == distPath));
    }
    return result;
  }
}
