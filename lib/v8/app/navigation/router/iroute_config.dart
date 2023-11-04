import 'package:flutter/material.dart';

class IRouteConfig {
  final Object? extra;
  final bool forResult;
  final Uri uri;
  final bool keepAlive;
  final bool recordHistory;

  const IRouteConfig({
    this.extra,
    required this.uri,
    this.forResult = false,
    this.keepAlive = false,
    this.recordHistory = false,
  });

  String get path => uri.path;

  IRouteConfig copyWith({
    Object? extra,
    bool? forResult,
    bool? keepAlive,
    bool? recordHistory,
  }) =>
      IRouteConfig(
        extra: extra ?? this.extra,
        forResult: forResult ?? this.forResult,
        keepAlive: keepAlive ?? this.keepAlive,
        recordHistory: recordHistory ?? this.recordHistory,
        uri: uri,
      );

  ValueKey get pageKey => ValueKey(path);
}
