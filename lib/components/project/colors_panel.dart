import 'package:flutter/material.dart';

class ColorsPanel extends StatelessWidget {
  final List<Color> colors;
  final ValueChanged<Color> onSelect;
  const ColorsPanel({super.key, required this.colors, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: colors
            .asMap()
            .keys
            .map((int index) => GestureDetector(
          onTap: () => onSelect(colors[index]),
          child: Container(
            alignment: Alignment.center,
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: colors[index],
                borderRadius: BorderRadius.circular(8)),
            child: Text(
              '$index',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ))
            .toList(),
      ),
    );
  }
}