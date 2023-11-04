import 'package:flutter/material.dart';

import '../../functions.dart';
import '../../provider/state.dart';

class CodePage extends StatelessWidget {
  const CodePage({super.key});

  @override
  Widget build(BuildContext context) {
    SortState state = SortStateScope.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          title: Text(sortNameMap[state.config.name]!+'代码实现'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('代码'*1000),
        ));
  }
}
