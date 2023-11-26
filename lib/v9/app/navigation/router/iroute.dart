import 'package:flutter/material.dart';
import 'package:iroute/v9/app/navigation/router/views/navigator_scope.dart';

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

  List<IRouteNode> find(
    String input,
  ) {
    String prefix = '/';
    if (this is CellIRoute) {
      input = input.replaceFirst(path, '');
      if (path != '/') {
        prefix = path + "/";
      }
    }

    return findNodes(this, Uri.parse(input), 0, prefix, []);
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
      target = prefix + target;

      List<IRouteNode> nodes =
          node.children.where((e) => e.path == target).toList();
      bool match = nodes.isNotEmpty;
      if (match) {
        IRouteNode matched = nodes.first;
        result.add(matched);
        String nextPrefix = '${matched.path}/';
        findNodes(matched, uri, ++deep, nextPrefix, result);
      } else {
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
class NotFindNode extends IRouteNode {
  NotFindNode({required super.path, super.children = const []});

  @override
  Page? createPage(BuildContext context, IRouteConfig config) {
    return null;
  }
}

typedef CellBuilder = Widget Function(
  BuildContext context,
  IRouteConfig config,
  Widget navigator,
);

typedef CellIRoutePageBuilder = Page? Function(
    BuildContext context,
    IRouteConfig data,
    Widget child,
    );

class CellIRoute extends IRouteNode {
  final CellBuilder cellBuilder;
  final CellIRoutePageBuilder? pageBuilder;

  const CellIRoute({
    required this.cellBuilder,
    this.pageBuilder,
    required super.path,
    required super.children,
  });

  @override
  Page? createPage(BuildContext context, IRouteConfig config) {
    return null;
  }

  Page? createCellPage(BuildContext context, IRouteConfig config,
      Widget child) {
    if (pageBuilder != null) {
      return pageBuilder!(context, config, child);
    }
    return MaterialPage(
      child: child,
      key: config.pageKey,
    );
  }
}