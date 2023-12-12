import 'package:flutter/material.dart';

import '../../../components/toly_ui/decoration/title.dart';

class TitleGroup extends StatelessWidget {
  final String title;
  final Color? color;
  final Color? lineColor;

  const TitleGroup({super.key, required this.title, this.color=const Color(0xff333333), this.lineColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: TolyTitle(
          color: color,
          lineColor: lineColor,
          child:
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 10),
            child: Text(
              title,
              style: TextStyle(fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),  ),
      ),
    );
  }
}
