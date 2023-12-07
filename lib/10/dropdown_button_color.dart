// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// Flutter code sample for [DropdownButton.selectedItemBuilder].

const Map<String, Color> kColors = <String, Color>{
  '红色': Colors.red,
  '黄色': Colors.yellowAccent,
  '蓝色': Colors.blue,
  '绿色': Colors.greenAccent,
  '橙色': Colors.orange,
  '紫色': Colors.purple,
};

class DropdownButtonColor extends StatefulWidget {
  const DropdownButtonColor({super.key});

  @override
  State<DropdownButtonColor> createState() => _DropdownButtonColorState();
}

class _DropdownButtonColorState extends State<DropdownButtonColor> {
  String selectedItem = kColors.keys.first;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('选择颜色:', style: Theme.of(context).textTheme.bodyLarge),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DropdownButton<String>(
            value: selectedItem,
            onChanged: (String? value) {
              setState(() => selectedItem = value!);
            },
            selectedItemBuilder: _buildSelectItem,
            items: _buildItems(),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _buildItems(){
   return kColors.keys.map<DropdownMenuItem<String>>((String key) {
      return DropdownMenuItem<String>(
        value: key,
        child: Wrap(
          spacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                  color: kColors[key],
                  borderRadius: BorderRadius.circular(2)),
            ),
            Text(key),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _buildSelectItem(BuildContext context) {
      return kColors.values.map<Widget>((Color color) {
        return Align(
          child: Container(
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2)),
            constraints: const BoxConstraints(minWidth: 24,maxHeight: 24),
          ),
        );
      }).toList();
  }
}
