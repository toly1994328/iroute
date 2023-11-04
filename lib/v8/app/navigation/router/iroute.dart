import 'package:flutter/material.dart';


import 'iroute_config.dart';

typedef IRoutePageBuilder = Page? Function(
  BuildContext context,
  IRouteConfig data,
);

typedef IRouteWidgetBuilder = Widget? Function(
  BuildContext context,
  IRouteConfig data,
);

abstract class IRouteNode {
  final String path;
  final List<IRouteNode> children;

  const IRouteNode({
    required this.path,
    required this.children,
  });

  Page? createPage(BuildContext context, IRouteConfig config);

  List<IRouteNode> find(String input,) {
    return findNodes(this, Uri.parse(input), 0, '/', []);
  }

  List<IRouteNode> findNodes(
    IRouteNode node,
    Uri uri,
    int deep,
    String prefix,
    List<IRouteNode> result,
  ) {
    List<String> parts = uri.pathSegments;
    if (deep > parts.length - 1) {
      return result;
    }
    String target = parts[deep];
    if (node.children.isNotEmpty) {
      target =  prefix + target;
      List<IRouteNode> nodes = node.children.where((e) => e.path == target).toList();
      bool match = nodes.isNotEmpty;
      if (match) {
        IRouteNode matched = nodes.first;
        result.add(matched);
        String nextPrefix = '${matched.path}/';
        findNodes(matched, uri, ++deep, nextPrefix, result);
      }else{
        result.add(NotFindNode(path: target));
        return result;
      }
    }
    return result;
  }
}

/// 优先调用 [pageBuilder] 构建 Page
/// 没有 [pageBuilder] 时, 使用 [widgetBuilder] 构建组件
/// 没有  [pageBuilder] 和 [widgetBuilder] 时, 使用 [widget] 构建组件
class IRoute extends IRouteNode {
  final IRoutePageBuilder? pageBuilder;
  final IRouteWidgetBuilder? widgetBuilder;
  final Widget? widget;

  const IRoute({
    required super.path,
    super.children = const [],
    this.widget,
    this.pageBuilder,
    this.widgetBuilder,
  });

  @override
  Page? createPage(BuildContext context, IRouteConfig config) {
    if (pageBuilder != null) {
      return pageBuilder!(context, config);
    }
    Widget? child;
    if (widgetBuilder != null) {
      child = widgetBuilder!(context, config);
    }
    child ??= widget;
    if (child != null) {
      return MaterialPage(child: child, key: config.pageKey);
    }
    return null;
  }
}

/// 未知路由
class NotFindNode extends IRouteNode{
  NotFindNode({required super.path, super.children= const[]});

  @override
  Page? createPage(BuildContext context, IRouteConfig config) {
    return null;
  }
}

class CellIRouter extends IRoute {
  final CellBuilder cellBuilder;

  CellIRouter(
      {required super.path,
      super.pageBuilder,
      super.children,
      required this.cellBuilder});
}

typedef CellBuilder = Widget Function(BuildContext context, Widget child);

