import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'iroute_config.dart';

class AppRouterParser extends RouteInformationParser<IRouteConfig> {
  @override
  RouteInformation restoreRouteInformation(IRouteConfig configuration) {
    return RouteInformation(uri: configuration.uri);
  }

  @override
  Future<IRouteConfig> parseRouteInformationWithDependencies(
    RouteInformation routeInformation,
    BuildContext context,
  )  {
    return SynchronousFuture(IRouteConfig(uri: routeInformation.uri));
  }
}
