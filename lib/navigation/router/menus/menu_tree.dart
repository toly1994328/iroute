import 'package:toly_menu/toly_menu.dart';

import 'anima.dart';
import 'draw.dart';
import 'dream.dart';
import 'layout.dart';
import 'render.dart';
import 'scroll.dart';
import 'touch.dart';

Map<String, dynamic> root = {
  'path': '',
  'label': '',
  'children': [
    dashboard,
    drawMenus,
    layoutMenus,
    dreamMenus,
    animaMenus,
    touchMenus,
    scrollMenus,
    renderMenus,
  ]
};

Map<String, dynamic> dashboard = {
  'path': '/dashboard',
  'label': '面板总览',
  'children': [
    {
      'path': '/view',
      'label': '小册全集',
    },
    {
      'path': '/chat',
      'label': '读者交流',
      'children': [
        {
          'path': '/a',
          'label': '第一交流区',
        },
        {
          'path': '/b',
          'label': '第二交流区',
        },
        {
          'path': '/c',
          'label': '第三交流区',
        },
      ]
    },
  ],
};

MenuNode get rootMenu => parser(root, -1, '');

MenuNode parser(Map<String, dynamic> data, int deep, String prefix) {
  String path = data['path'];
  String label = data['label'];
  List<Map<String, dynamic>>? childrenMap = data['children'];
  List<MenuNode> children = [];
  if (childrenMap != null && childrenMap.isNotEmpty) {
    for (int i = 0; i < childrenMap.length; i++) {
      MenuNode cNode = parser(childrenMap[i], deep + 1, prefix + path);
      children.add(cNode);
    }
  }
  return MenuNode(
    path: prefix + path,
    label: label,
    deep: deep,
    children: children,
  );
}
