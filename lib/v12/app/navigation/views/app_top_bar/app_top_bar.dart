import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iroute/components/components.dart';
import '../../helper/function.dart';
import '../route_back_indicator.dart';
import 'app_router_editor.dart';
import 'route_history_button.dart';
import 'history_view_icon.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DragToMoveWrap(
      child: Container(
        // alignment: Alignment.center,
        height: 46,
        child: Row(
          children: [
            const SizedBox(width: 16),
            const RouteBackIndicator(),
            const RouterIndicator(),
            // Spacer(),
            Expanded(
                child: Row(textDirection: TextDirection.rtl, children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: VerticalDivider(
                  width: 32,
                ),
              ),
              HistoryViewIcon(),
              const SizedBox(
                width: 12,
              ),
              SizedBox(
                  width: 250,
                  child: AppRouterEditor(
                    onSubmit: (path) {
                      GoRouter.of(context).go(path);
                      // => router.changePath(path)
                    },
                  )),
              const SizedBox(
                width: 12,
              ),
              RouteHistoryButton(),
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

class _RouterIndicatorState extends State<RouterIndicator> {
  late GoRouterDelegate _delegate;
  @override
  void initState() {
    super.initState();
    _delegate = GoRouter.of(context).routerDelegate;
    _delegate.addListener(_onRouterChange);
  }

  @override
  void dispose() {
    _delegate.removeListener(_onRouterChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<RouteMatch> matches = _delegate.currentConfiguration.matches;
    if(matches.isEmpty) return const SizedBox();
    RouteMatch match = _delegate.currentConfiguration.matches.last;

    print(
        "=========_RouterIndicatorState:build==${match.matchedLocation}========");

    return TolyBreadcrumb(
      items: pathToBreadcrumbItems(context, match.matchedLocation),
      onTapItem: (item) {
        if (item.to != null) {
          GoRouter.of(context).go(item.to!);
        }
      },
    );
  }

  void _onRouterChange() {
    setState(() {});
  }

  List<BreadcrumbItem> pathToBreadcrumbItems(
      BuildContext context, String path) {
    Uri uri = Uri.parse(path);
    List<BreadcrumbItem> result = [];
    String to = '';

    String distPath = '';
    for (String segment in uri.pathSegments) {
      distPath += '/$segment';
    }

    for (String segment in uri.pathSegments) {
      to += '/$segment';
      String label = calcRouteName(context, to);
      if (label.isNotEmpty) {
        result
            .add(BreadcrumbItem(to: to, label: label, active: to == distPath));
      }
    }
    return result;
  }
}

Map<String, String> kRouteLabelMap = {
  '': '',
  '/color': '颜色板',
  '/color/add': '添加颜色',
  '/color/detail': '颜色详情',
  '/counter': '计数器',
  '/sort': '排序算法',
  '/sort/player': '演示',
  '/sort/settings': '排序配置',
  '/user': '我的',
  '/settings': '系统设置',
};
