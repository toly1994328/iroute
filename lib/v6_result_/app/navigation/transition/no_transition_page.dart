// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class NoTransitionPage<T> extends Page<T> {
  final Widget child;

  const NoTransitionPage({
    super.key,
    required this.child,
  });

  @override
  Route<T> createRoute(BuildContext context) => NoTransitionRoute<T>(this);
}

class NoTransitionRoute<T> extends PageRoute<T> {

  final NoTransitionPage<T> _page;

  NoTransitionRoute(this._page) : super(settings: _page);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return (settings as NoTransitionPage).child;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      child;
}
