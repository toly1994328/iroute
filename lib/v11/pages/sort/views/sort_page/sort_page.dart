
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../app/navigation/router/iroute_config.dart';
import '../../../../app/navigation/router/app_router_delegate.dart';
import 'sort_button.dart';

import '../../functions.dart';
import '../../provider/state.dart';

class SortNavigation extends StatelessWidget {
  final Widget navigator;
  const SortNavigation({super.key, required this.navigator});

  @override
  Widget build(BuildContext context) {
    return  Material(
      child:  Row(
        children: [
          SizedBox(
            width: 220,
            child: SortRailPanel(),
          ),
          VerticalDivider(
            width: 1,
          ),
          Expanded(
            child: navigator,
          )
        ],
      ),
    );
  }
}

class SortRailPanel extends StatelessWidget {
  const SortRailPanel({super.key});

  @override
  Widget build(BuildContext context) {
    SortState state = SortStateScope.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              const SortButton(),
              const Spacer(),
              const MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Icon(
                  CupertinoIcons.chevron_left_slash_chevron_right,
                  size: 18,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                    onTap: () {
                      router.changePath('/app/sort/settings',style: RouteStyle.push);
                    },
                    child: const Icon(
                      CupertinoIcons.settings,
                      size: 18,
                    )),
              ),
            ],
          ),
        ),
        const Divider(
          height: 1,
        ),
        Expanded(
          child: SortSelectorPanel(
            active: state.config.name,
            options: sortNameMap.values.toList(),
            onSelected: (name) {
              state.selectName(name);
              router.changePath('/app/sort/${name}',recordHistory: true);
            },
          ),
        ),
      ],
    );
  }
}

class SortSelectorPanel extends StatelessWidget {
  final String active;
  final ValueChanged<String> onSelected;
  final List<String> options;

  const SortSelectorPanel(
      {super.key,
      required this.active,
      required this.options,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemExtent: 46,
      itemCount: sortNameMap.length,
      itemBuilder: _buildByIndex,
    );
  }

  Widget? _buildByIndex(BuildContext context, int index) {
    String key = sortNameMap.keys.toList()[index];
    bool selected = sortNameMap.keys.toList()[index] == active;
    return SortItemTile(
      selected: selected,
      onTap: () => onSelected(key),
      title: options[index],
    );
  }
}

class SortItemTile extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final bool selected;

  const SortItemTile(
      {super.key,
      required this.title,
      required this.selected,
      required this.onTap});

  @override
  State<SortItemTile> createState() => _SortItemTileState();
}

class _SortItemTileState extends State<SortItemTile> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: widget.selected ? const Color(0xffE6F0FF) : null),
            padding: const EdgeInsets.only(left: 12),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.title,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: widget.selected ? FontWeight.bold : null),
            ),
          ),
        ),
      ),
    );
  }
}
