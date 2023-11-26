import 'package:flutter/material.dart';

enum RouteStyle{
  push,
  replace,
}


class IRouteConfig {
  final Object? extra;
  final bool forResult;
  final Uri uri;
  final Map<String,String>? pathParams;
  final bool keepAlive;
  final RouteStyle routeStyle;
  final bool recordHistory;

  const IRouteConfig({
    this.extra,
    required this.uri,
    this.forResult = false,
    this.pathParams,
    this.keepAlive = false,
    this.routeStyle = RouteStyle.replace,
    this.recordHistory = false,
  });

  String get path => uri.toString();

  IRouteConfig copyWith({
    Object? extra,
    bool? forResult,
    bool? keepAlive,
    bool? recordHistory,
    String? path,
  }) =>
      IRouteConfig(
        extra: extra ?? this.extra,
        forResult: forResult ?? this.forResult,
        keepAlive: keepAlive ?? this.keepAlive,
        recordHistory: recordHistory ?? this.recordHistory,
        uri: path!=null?Uri.parse(path):uri,
      );

  ValueKey get pageKey => ValueKey(hashCode);


  @override
  String toString() {
    return 'IRouteConfig{extra: $extra, forResult: $forResult, uri: $uri, keepAlive: $keepAlive, routeStyle: $routeStyle, recordHistory: $recordHistory}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IRouteConfig &&
          runtimeType == other.runtimeType &&
          extra == other.extra &&
          forResult == other.forResult &&
          uri == other.uri &&
          keepAlive == other.keepAlive &&
          routeStyle == other.routeStyle &&
          recordHistory == other.recordHistory;

  @override
  int get hashCode =>
      extra.hashCode ^
      forResult.hashCode ^
      uri.hashCode ^
      keepAlive.hashCode ^
      routeStyle.hashCode ^
      recordHistory.hashCode;
}
