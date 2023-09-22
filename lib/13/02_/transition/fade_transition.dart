



import 'package:flutter/material.dart';


class FadeTransitionsBuilder extends PageTransitionsBuilder {
  /// Constructs a page transition animation that slides the page up.
  const FadeTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T>? route,
      BuildContext? context,
      Animation<double> animation,
      Animation<double>? secondaryAnimation,
      Widget child,
      ) {
    return _FadeUpwardsPageTransition(routeAnimation: animation, child: child);
  }
}

class _FadeUpwardsPageTransition extends StatelessWidget {
  _FadeUpwardsPageTransition({
    required Animation<double> routeAnimation, // The route's linear 0.0 - 1.0 animation.
    required this.child,
  }) : _positionAnimation = routeAnimation.drive(_bottomUpTween.chain(_fastOutSlowInTween)),
        _opacityAnimation = routeAnimation.drive(_easeInTween);

  // Fractional offset from 1/4 screen below the top to fully on screen.
  static final Tween<Offset> _bottomUpTween = Tween<Offset>(
    begin: const Offset(0.25,0),
    end: Offset.zero,
  );
  static final Animatable<double> _fastOutSlowInTween = CurveTween(curve: Curves.fastOutSlowIn);
  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);

  final Animation<Offset> _positionAnimation;
  final Animation<double> _opacityAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // return FadeTransition(
    //   opacity: _opacityAnimation,
    //   child: child,
    // );

    return SlideTransition(
      position: _positionAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: child,
      ),
    );
  }
}