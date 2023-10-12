// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:quiver/core.dart';

/// A route path that has been parsed by [TemplateRouteParser].
class ParsedRoute extends Equatable{
  /// The current path location without query parameters. (/book/123)
  final String path;

  /// The query parameters ({search: abc})
  final Map<String, String> queryParameters;

  const ParsedRoute(this.path,  this.queryParameters);

  @override
  List<Object?> get props => [path,queryParameters];
}
