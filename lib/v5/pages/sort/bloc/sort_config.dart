import 'dart:ui';

import 'package:flutter/material.dart';

class SortConfig {
  final int count;
  final int seed;
  final Duration duration;
  final String name;

  SortConfig(this.count, this.duration,this.seed,this.name);
}

final ValueNotifier<SortConfig> sortConfig = ValueNotifier(
  SortConfig(-1, const Duration(microseconds: 1500),-1,'quick'),
);


final ValueNotifier<String> sortName = ValueNotifier('quick');
