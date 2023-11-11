import 'package:flutter/material.dart';
import '../iroute.dart';

import '../iroute_config.dart';

class NavigatorScope extends StatefulWidget {
  final IRouteNode node;
  final PopPageCallback onPopPage;
  final List<IRouteConfig> configs;
  final IRoutePageBuilder notFindPageBuilder;

  const NavigatorScope({
    super.key,
    required this.node,
    required this.onPopPage,
    required this.configs,
    required this.notFindPageBuilder,
  });

  @override
  State<NavigatorScope> createState() => _NavigatorScopeState();
}

class _NavigatorScopeState extends State<NavigatorScope> {
  @override
  Widget build(BuildContext context) {
    Widget content = Navigator(
      onPopPage: widget.onPopPage,
      pages: _buildPages(context, widget.configs),
    );

    if(widget.node is CellIRoute){
      content = (widget.node as CellIRoute).cellBuilder(context,widget.configs.last,content);
    }
    return HeroControllerScope(
      controller:  MaterialApp.createMaterialHeroController(),
      child: content,
    );
  }

  List<Page> _buildPages(BuildContext context, List<IRouteConfig> configs) {
    IRouteConfig top = configs.last;
    List<IRouteConfig> bottoms =
        configs.sublist(0, configs.length - 1).toList();
    List<Page> pages = [];
    List<Page> topPages = _buildPageByPathFromTree(context, top);
    pages = _buildLivePageByPathList(context, bottoms, top, topPages);
    pages.addAll(topPages);
    return pages;
  }

  List<Page> _buildLivePageByPathList(
    BuildContext context,
    List<IRouteConfig> paths,
    IRouteConfig curConfig,
    List<Page> curPages,
  ) {
    List<Page> pages = [];
    if (paths.isNotEmpty) {
      for (IRouteConfig path in paths) {
        if (path != curConfig) {
          pages.addAll(_buildPageByPathFromTree(context, path));
        }
      }
      /// 去除和 curPages 中重复的界面
      pages.removeWhere((page) => curPages.map((e) => e.key).contains(page.key));
    }
    return pages;
  }

  List<Page> _buildPageByPathFromTree(
      BuildContext context, IRouteConfig config) {
    List<Page> result = [];
    List<IRouteNode> iRoutes = widget.node.find(config.path);

    if (iRoutes.isNotEmpty) {
      for (int i = 0; i < iRoutes.length; i++) {
        IRouteNode iroute = iRoutes[i];
        IRouteConfig fixConfig = config;

        if(iroute.path!=config.uri.path){
          fixConfig = IRouteConfig(uri: Uri.parse(iroute.path));
        }

        Page? page;
        if (iroute is NotFindNode) {
          page = widget.notFindPageBuilder(context, config);
        } else if (iroute is CellIRoute) {
          Widget scope = NavigatorScope(
            node: iroute,
            onPopPage: widget.onPopPage,
            configs: widget.configs,
            notFindPageBuilder: widget.notFindPageBuilder,
          );
          page = iroute.createCellPage(context, fixConfig, scope);
        } else {
          page = iroute.createPage(context, fixConfig);
        }
        if (page != null) {
          result.add(page);
        }
        if (iroute is CellIRoute) {
          break;
        }
      }
    }
    return result;
  }
}
