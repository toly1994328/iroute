
import 'package:iroute/navigation/router/menus/menu_tree.dart';
import 'package:toly_menu/toly_menu.dart';



void main() {

  MenuNode node = parser(root, -1, '');
  print(node);
  List<MenuNode> result = findNodes(node,Uri.parse('/dashboard/view'),0,'/',[]);
  print(result);
}

MenuNode? queryMenuNodeByPath(MenuNode node, String path) {
  if(node.path==path){
    return node;
  }
  if(node.children.isNotEmpty){
    for(int i=0;i<node.children.length;i++){
      MenuNode? result = queryMenuNodeByPath(node.children[i], path);
      if(result!=null){
        return result;
      }
    }
  }
  return null;
}

List<MenuNode> findNodes(
    MenuNode node,
    Uri uri,
    int deep,
    String prefix,
    List<MenuNode> result,
    ) {
  List<String> parts = uri.pathSegments;
  if (deep > parts.length - 1) {
    return result;
  }
  String target = parts[deep];
  if (node.children.isNotEmpty) {
    target =  prefix + target;
    List<MenuNode> nodes = node.children.where((e) => e.path == target).toList();
    bool match = nodes.isNotEmpty;
    if (match) {
      MenuNode matched = nodes.first;
      result.add(matched);
      String nextPrefix = '${matched.path}/';
      findNodes(matched, uri, ++deep, nextPrefix, result);
    }
  }
  return result;
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
