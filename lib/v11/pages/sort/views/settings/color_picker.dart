import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  final List<MaterialColor> colors;
  final ValueChanged<int> onSelected;
  final int activeIndex;

  const ColorPicker({
    super.key,
    required this.colors,
    required this.activeIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: colors
          .asMap()
          .keys
          .map((int index) => MouseRegion(
        cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: ()=>onSelected(index),
              child: Container(
                    width: 32,
                    height: 32,
                    color: colors[index],
                    child: activeIndex == index
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : null,
                  ),
            ),
          ))
          .toList(),
    );
  }
}
