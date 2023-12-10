import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iroute/components/components.dart';

class EmptyPage extends StatelessWidget {
  final String msg;
  const EmptyPage({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return  DragToMoveWrap(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(46),
          child: Row(
            children: [
              const SizedBox(width: 20,),
              Text(
                '404 界面丢失',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              const WindowButtons()
            ],
          ),
        ),
          body: Center(
            child: Wrap(
              spacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              children: [
                Icon(Icons.nearby_error,size: 64, color: Colors.redAccent),
                Text(
                  msg,
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ),
                ElevatedButton(onPressed: (){
                  context.go('/');
                }, child: Text('返回首页'))
              ],
            ),
          ),
      ),
    );
  }
}

