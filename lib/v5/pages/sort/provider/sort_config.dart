import 'dart:ui';

import 'package:flutter/material.dart';

class SortConfig {
  final int count;
  final int seed;
  final Duration duration;

  SortConfig(this.count, this.duration,this.seed);
}

final ValueNotifier<SortConfig> sortConfig = ValueNotifier(
  SortConfig(-1, const Duration(microseconds: 1500),-1),
);


final ValueNotifier<String> sortName = ValueNotifier('quick');
