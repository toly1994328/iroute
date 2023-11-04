
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'sort_button.dart';

import '../functions.dart';
import '../provider/state.dart';
import 'data_painter.dart';

class SortPage extends StatelessWidget {
  const SortPage({super.key});

  @override
  Widget build(BuildContext context) {
    SortState state = SortStateScope.of(context);
    List<int> numbers = state.data;
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 220,
            child: Column(
              children: [
                Container(
                  // color: Color(0xffF4F4F4),
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                  child:  Row(
                    children: [
                      SortButton(),
                      Spacer(),
                    ],
                  ),
                ),
                Divider(height: 1,),
                Expanded(
                  child: SortSelectorPanel(
                    active: state.config.name,
                    options: sortNameMap.values.toList(),
                    onSelected: state.selectName,
                  ),
                ),

              ],
            ),
          ),
          VerticalDivider(width: 1,),
          Expanded(
            child:  NavigatorScope(),
          )
        ],
      ),
    );
  }

  void _onSelected(String value) {

  }
}

final GlobalKey key = GlobalKey();

class NavigatorScope extends StatefulWidget {
  const NavigatorScope({super.key});

  @override
  State<NavigatorScope> createState() => _NavigatorScopeState();
}

class _NavigatorScopeState extends State<NavigatorScope> {

  @override
  Widget build(BuildContext context) {
    SortState state = SortStateScope.of(context);
    List<int> numbers = state.data;
    return Navigator(
      onPopPage: _onPopPage,
      key: key,
      pages: [
        MaterialPage(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CustomPaint(
            painter: DataPainter(data: numbers),
            child: ConstrainedBox(constraints: BoxConstraints.expand()),
          ),
        ))
      ],
    );
  }

  bool _onPopPage(Route<dynamic> route, result) {
    return route.didPop(result);
  }
}



class SortSelectorPanel extends StatelessWidget {
  final String active;
  final ValueChanged<String> onSelected;
  final List<String> options;

  const SortSelectorPanel(
      {super.key, required this.active, required this.options, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8),
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
      onTap: ()=>onSelected(key),
      title: options[index],
    );
  }
}

class SortItemTile extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final bool selected;
  const SortItemTile({super.key, required this.title, required this.selected, required this.onTap});

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
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: widget.selected?Color(0xffE6F0FF):null
            ),
            padding: EdgeInsets.only(left: 12),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 14,
              fontWeight: widget.selected?FontWeight.bold:null
              ),
            ),
          ),
        ),
      ),
    );
  }
}

