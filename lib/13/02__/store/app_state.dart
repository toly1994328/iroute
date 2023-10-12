
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier{
  final List<Color> colors;

  AppState({required this.colors,});

  AppState.initial():colors=[
    Colors.red, Colors.black, Colors.blue, Colors.green, Colors.orange,
    Colors.pink, Colors.purple, Colors.indigo, Colors.amber, Colors.cyan,
    Colors.redAccent, Colors.grey, Colors.blueAccent, Colors.greenAccent, Colors.orangeAccent,
    Colors.pinkAccent, Colors.purpleAccent, Colors.indigoAccent, Colors.amberAccent, Colors.cyanAccent,
  ];

  void addColor(Color color){
    colors.add(color);
    notifyListeners();
  }

}

/// Provides the current [RouteState] to descendant widgets in the tree.
class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({super.key, required super.child,  required super.notifier,});



  static AppState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppStateScope>()!.notifier!;
}
