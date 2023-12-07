import 'package:flutter/material.dart';

enum MenuAction implements Comparable<MenuAction> {
  setting(label: '应用设置', iconData: Icons.settings),
  about(label: '关于应用', iconData: Icons.info),
  help(label: '帮助中心', iconData: Icons.help);

  final String label;
  final IconData iconData;

  const MenuAction({
    required this.label,
    required this.iconData,
  });

  @override
  int compareTo(MenuAction other) => label.compareTo(other.label);

  bool operator >(MenuAction other) {
    return compareTo(other) > 0;
  }
}

class MorePopIcon extends StatelessWidget {
  final ValueChanged<MenuAction> onTapItem;
  const MorePopIcon({super.key, required this.onTapItem});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      itemBuilder: _buildItem,
      onSelected: onTapItem,
      icon: const Icon(Icons.more_vert_outlined),
      position: PopupMenuPosition.under,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }

  List<PopupMenuEntry<MenuAction>> _buildItem(BuildContext context) {
    return MenuAction.values
        .map((MenuAction action) => PopupMenuItem<MenuAction>(
              height: 35,
              value: action,
              child: Center(
                  child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 6,
                children: [
                  Text(action.label),
                  Icon(action.iconData, size: 18),
                ],
              )),
            ))
        .toList();
  }
}
