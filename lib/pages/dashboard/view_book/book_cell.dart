import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/events.dart';

import '../view_books.dart';

class BookCell extends StatefulWidget {
  final BookInfo bookInfo;
  final ValueChanged<BookInfo> onSelect;
  const BookCell({super.key, required this.bookInfo, required this.onSelect});

  @override
  State<BookCell> createState() => _BookCellState();
}

class _BookCellState extends State<BookCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> widget.onSelect(widget.bookInfo),
      child: MouseRegion(
        onEnter: _onEnter,
        cursor: SystemMouseCursors.click,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Center(child: ClipRRect(
                        child: Image.asset(widget.bookInfo.cover),
                        borderRadius:BorderRadius.circular(8)
                    ))),
                const SizedBox(height: 8),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '${widget.bookInfo.info}',
                    style:
                    TextStyle(fontSize: 12, color: Color(0xff515767)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onEnter(PointerEnterEvent event) {

  }
}
