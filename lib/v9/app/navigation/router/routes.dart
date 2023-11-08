import 'package:flutter/material.dart';
import '../../../pages/sort/views/player/sort_player.dart';
import 'iroute_config.dart';
import 'iroute.dart';
import '../../../pages/color/color_add_page.dart';
import '../../../pages/color/color_detail_page.dart';
import '../../../pages/color/color_page.dart';
import '../../../pages/counter/counter_page.dart';
import '../../../pages/user/user_page.dart';
import '../../../pages/settings/settings_page.dart';
import '../../../pages/sort/views/sort_page/sort_page.dart';
import '../../../pages/sort/views/settings/sort_setting.dart';

IRoute rootRoute = const IRoute(
  path: 'root',
  children: [
    IRoute(
      path: '/color',
      widget: ColorPage(),
      children: [
        IRoute(path: '/color/detail', widgetBuilder: _buildColorDetail),
        IRoute(path: '/color/add', widget: ColorAddPage()),
      ],
    ),
    IRoute(path: '/counter', widget: CounterPage()),
    CellIRoute(
      path: '/sort',
      widget: SortPage(),
      children: [
        IRoute(
          path: '/sort/settings',
          widget: SortSettings(),
        ),
        IRoute(
          path: '/sort/player',
          widget: SortPlayer(),
        ),
      ],
    ),
    IRoute(path: '/user', widget: UserPage()),
    IRoute(path: '/settings', widget: SettingPage()),
  ],
);

Widget? _buildColorDetail(BuildContext context, IRouteConfig data) {
  final Map<String, String> queryParams = data.uri.queryParameters;
  String? selectedColor = queryParams['color'];
  Color color = Colors.black;
  if (selectedColor != null) {
    color = Color(int.parse(selectedColor, radix: 16));
  } else if (data.extra is Color) {
    color = data.extra as Color;
  }
  return ColorDetailPage(color: color);
}
