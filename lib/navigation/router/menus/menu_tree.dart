import 'package:flutter/cupertino.dart';
import 'package:toly_menu/toly_menu.dart';

import 'anima.dart';
import 'dashboard.dart';
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


MenuNode get rootMenu => parser(root, -1, '');

MenuNode parser(Map<String, dynamic> data, int deep, String prefix) {
  String path = data['path'];
  String label = data['label'];
  IconData? icon = data['icon'];
  List<Map<String, dynamic>>? childrenMap = data['children'];
  List<MenuNode> children = [];
  if (childrenMap != null && childrenMap.isNotEmpty) {
    for (int i = 0; i < childrenMap.length; i++) {
      MenuNode cNode = parser(childrenMap[i], deep + 1, prefix + path);
      children.add(cNode);
    }
  }
  return MenuNode(
    icon: icon,
    path: prefix + path,
    label: label,
    deep: deep,
    children: children,
  );
}
