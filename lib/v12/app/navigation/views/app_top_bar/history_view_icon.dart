import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iroute/components/components.dart';
import 'package:iroute/v11/app/navigation/helper/function.dart';
import '../../helper/router_history.dart';
import 'app_top_bar.dart';

class HistoryViewIcon extends StatelessWidget{
  const HistoryViewIcon({super.key});

  @override
  Widget build(BuildContext context) {
    RouterHistory routerHistory = RouterHistoryScope.read(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: PopPanel(
        offset: const Offset(0, 10),
        panel: SizedBox(
          height: 350,
          child: Column(
            children: [
              _buildTopBar(routerHistory),
              const Expanded(
                child:HistoryPanel(),
              ),
            ],
          ),
        ),
        child: const Icon(
          Icons.history,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildTopBar( RouterHistory routerHistory) {
   return Container(
        decoration: BoxDecoration(
          color: const Color(0xffFAFAFC),
          borderRadius: BorderRadius.circular(6),
        ),
        padding:
        const EdgeInsets.only(top: 10, left: 12, right: 12, bottom: 8),
        child: Row(
          children: [
            const Text(
              '浏览历史',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            TextButton(onPressed: routerHistory.clear, child: const Text('清空历史'))
          ],
        ));
  }
}

class HistoryItem extends StatefulWidget {
  final RouteMatchList history;
  final VoidCallback onPressed;
  final VoidCallback onDelete;

  const HistoryItem({super.key, required this.history, required this.onPressed, required this.onDelete});

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  @override
  Widget build(BuildContext context) {
    String path = widget.history.matches.last.matchedLocation;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onPressed,
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(path),
                const SizedBox(
                  height: 2,
                ),
                Text(calcRouteName(context, path)),
              ],
            )),
            GestureDetector(
              onTap: widget.onDelete,
              child: const Icon(
                Icons.close,
                size: 18,
                color: Color(0xff8E92A9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryPanel extends StatefulWidget {
  const HistoryPanel({super.key});

  @override
  State<HistoryPanel> createState() => _HistoryPanelState();
}

class _HistoryPanelState extends State<HistoryPanel> {
  late RouterHistory _history ;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _history = RouterHistoryScope.of(context);
  }


  @override
  Widget build(BuildContext context) {
    List<RouteMatchList> histories = _history.histories.reversed.toList();
    if(histories.isEmpty){
      return const Center(
        child: Text(
          '暂无浏览历史记录',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      itemExtent: 46,
      itemCount: histories.length,
      itemBuilder: (_, index) =>
          HistoryItem(
              onDelete: (){
                _history.close(histories[index]);
              },
              onPressed: ()async {
                Navigator.of(context).pop();
                _history.select(histories[index]);
                // router.changeRoute(histories[index].copyWith(recordHistory: false));
              },
              history: histories[index]),
    );
  }

  void _onChange() {
    setState(() {});
  }
}
