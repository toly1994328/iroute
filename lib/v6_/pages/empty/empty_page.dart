import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('界面走丢了'),
      // ),
      body: Scaffold(
        body: Center(
          child: Wrap(
            spacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.vertical,
            children: [
              Icon(Icons.nearby_error,size: 64, color: Colors.grey),
              Text(
                '404 界面丢失',
                style: TextStyle(fontSize: 24, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
