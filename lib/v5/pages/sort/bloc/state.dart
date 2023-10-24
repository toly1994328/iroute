import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../functions.dart';
import 'sort_config.dart';

enum SortStatus{
  none, // 未操作
  sorting, // 排序中
  sorted, // 排序完成
}

class SortState with ChangeNotifier{

  SortStatus status = SortStatus.none;

  List<int> data = [];

  SortConfig _config = SortConfig(-1, const Duration(microseconds: 1500),-1,'quick');
  SortConfig get config => _config;
  Random random = Random();

  set config(SortConfig config){
    _config = config;
    reset(_zoneSize);
    notifyListeners();
  }

  Size _zoneSize = Size.zero;

  void reset(Size zoneSize){
    _zoneSize = zoneSize;
    status = SortStatus.sorting;
    int count = config.count;
    if(count==-1){
      count = zoneSize.width~/2;
    }
    if(config.seed!=-1){
      random = Random(config.seed);
    }
    for (int i = 0; i < count; i++) {
      //随机往数组中填值
      data.add(random.nextInt(zoneSize.height.toInt()));
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
        data = arr;
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
}