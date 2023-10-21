import 'package:flutter/material.dart';

import 'menu_meta.dart';

// final List<NavigationRailDestination> destinations = const [
//   NavigationRailDestination(icon: Icon(Icons.color_lens_outlined), label: Text("颜色板")),
//   NavigationRailDestination(icon: Icon(Icons.add_chart), label: Text("计数器")),
//   NavigationRailDestination(icon: Icon(Icons.person), label: Text("我的")),
//   NavigationRailDestination(icon: Icon(Icons.settings), label: Text("设置")),
// ];

const List<MenuMeta> kDeskNavBarMenus = [
  MenuMeta(label: '颜色板', icon: Icons.color_lens_outlined),
  MenuMeta(
    label: '计数器',
    icon: Icons.add_chart,
  ),
  MenuMeta(
    label: '我的',
    icon: Icons.person,
  ),
  MenuMeta(label: '设置', icon: Icons.settings),
];

class TolyNavigationRail extends StatelessWidget {
  final ValueChanged<int> onDestinationSelected;
  final Color backgroundColor;
  final int? selectedIndex;
  final Widget? leading;

  const TolyNavigationRail({
    Key? key,
    required this.onDestinationSelected,
    required this.selectedIndex,
    this.leading,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      color: backgroundColor,
      child: Column(
        children: [
          if(leading!=null) leading!,
          Expanded(
              child: LeftNavigationMenu(
            items: kDeskNavBarMenus,
            selectedIndex: selectedIndex,
            onTapItem: onDestinationSelected,
          )),
          // if (selectedIndex == 0) HelpButton()
        ],
      ),
    );
  }
}

class LeftNavigationMenu extends StatelessWidget {
  final List<MenuMeta> items;
  final ValueChanged<int> onTapItem;

  final int? selectedIndex;

  const LeftNavigationMenu(
      {Key? key,
      required this.items,
      required this.selectedIndex,
      required this.onTapItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.asMap().keys.map((int index) {
        return LeftNavigationBarItemWidget(
          item: items[index],
          selected: index == selectedIndex,
          onTap: () {
            onTapItem.call(index);
          },
        );
      }).toList(),
    );
  }
}

class LeftNavigationBarItemWidget extends StatefulWidget {
  final MenuMeta item;
  final bool selected;
  final VoidCallback onTap;

  const LeftNavigationBarItemWidget(
      {Key? key,
      required this.item,
      required this.selected,
      required this.onTap})
      : super(key: key);

  @override
  State<LeftNavigationBarItemWidget> createState() =>
      _LeftNavigationBarItemWidgetState();
}

class _LeftNavigationBarItemWidgetState
    extends State<LeftNavigationBarItemWidget> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    Color? bgColor;
    Color iconColor;
    if (widget.selected) {
      bgColor = Colors.white.withOpacity(0.2);
      iconColor = Colors.white;
    } else {
      bgColor = _hover ? Colors.white.withOpacity(0.1) : null;
      iconColor = Colors.white.withOpacity(0.8);
    }

    return InkWell(
      onTap: widget.selected
          ? null
          : () {
              widget.onTap();
              setState(() {
                _hover = false;
              });
            },
      onHover: widget.selected
          ? null
          : (v) {
              setState(() {
                _hover = v;
              });
            },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 10),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(8)),
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 2,
          children: [
            Icon(
              widget.item.icon,
              color: iconColor,
            ),
            Text(
              widget.item.label,
              style: TextStyle(color: iconColor, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
