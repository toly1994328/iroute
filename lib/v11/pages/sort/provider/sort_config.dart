import 'dart:ui';

import 'package:flutter/material.dart';

class SortConfig {
  final int count;
  final int seed;
  final Duration duration;
  final String name;
  final int colorIndex;

  SortConfig({
     this.count = 100,
     this.duration = const Duration(microseconds: 1500),
     this.seed = -1,
     this.colorIndex = 0,
     this.name = 'insertion',
  });

  SortConfig copyWith({
    int? count,
    int? seed,
    int? colorIndex,
    Duration? duration,
    String? name,
  }) =>
      SortConfig(
        count:count??this.count,
        seed:seed??this.seed,
        duration:duration??this.duration,
        name:name??this.name,
        colorIndex:colorIndex??this.colorIndex,
      );
}

