import 'package:iroute/navigation/router/menus/menu_tree.dart';
import 'package:toly_menu/toly_menu.dart';

void main() {
  Map<String, dynamic> data = dashboard;
  MenuNode node = parser(data, 0, '');
  print(node);
}

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
