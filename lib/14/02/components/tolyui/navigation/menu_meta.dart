import 'package:flutter/cupertino.dart';

class MenuMeta {
  // 标签
  final String label;

  // 图标数据
  final IconData icon;

  // 图标颜色
  final Color? color;

  const MenuMeta({
    required this.label,
    required this.icon,
    this.color,
  });
}
