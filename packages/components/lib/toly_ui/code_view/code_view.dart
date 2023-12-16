import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'code/code_widget.dart';
import 'code/highlighter_style.dart';

class CodeView extends StatefulWidget {
  final String path;
  const CodeView({super.key, required this.path});

  @override
  State<CodeView> createState() => _CodeViewState();
}

class _CodeViewState extends State<CodeView> {

  String? content;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadContent();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Material(
          child: CodeWidget(code:'${content}', style: HighlighterStyle.fromColors(HighlighterStyle.lightColor),),
        ),
      ),
    );
  }

  void _loadContent() async{
    content = await rootBundle.loadString(widget.path);
    setState(() {

    });
  }
}
