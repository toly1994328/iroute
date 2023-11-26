import 'dart:math';

import 'package:flutter/material.dart';

import '../functions.dart';
import 'sort_config.dart';

enum SortStatus{
  none, // 未操作
  sorting, // 排序中
  sorted, // 排序完成
}

List<MaterialColor> kColorSupport = [
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.red,
  Colors.pink,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.indigo,
  Colors.purple,
  Colors.deepPurple,
];

class SortState with ChangeNotifier{

  SortState(){
    reset();
  }

  SortStatus status = SortStatus.none;

  List<int> data = [];
  List<int> stepData = [];

  SortConfig _config = SortConfig();
  SortConfig get config => _config;
  Random random = Random();

  set config(SortConfig config){
    _config = config;
    reset();
    notifyListeners();
  }

  void selectName(String name){
    if(name==config.name) return;
    config = config.copyWith(name: name);
  }

  void selectColor(int colorIndex){
    if(colorIndex==config.colorIndex) return;
    config = config.copyWith(colorIndex: colorIndex);
  }

  void reset(){
    data.clear();
    status = SortStatus.none;
    notifyListeners();
    int count = config.count;
    if(config.seed!=-1){
      random = Random(config.seed);
    }
    for (int i = 0; i < count; i++) {
      //随机往数组中填值
      data.add(random.nextInt(1000));
    }
  }

  void sort() async{
    status = SortStatus.sorting;
    notifyListeners();
    Stopwatch stopwatch = Stopwatch()..start();
    SortFunction? sortFunction = sortFunctionMap[config.name];
    if(sortFunction!=null){
      await sortFunction(data,(arr) async {
        await Future.delayed(config.duration);
        notifyListeners();
      });
    }
    status = SortStatus.sorted;
    notifyListeners();
    stopwatch.stop();
    print("Sorting completed in ${stopwatch.elapsed.inMilliseconds} ms.");
  }
}

/// Provides the current [SortState] to descendant widgets in the tree.
class SortStateScope extends InheritedNotifier<SortState> {
  const SortStateScope({
    required super.notifier,
    required super.child,
    super.key,
  });

  static SortState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SortStateScope>()!.notifier!;

  static SortState read(BuildContext context) =>
      context.getInheritedWidgetOfExactType<SortStateScope>()!.notifier!;
}