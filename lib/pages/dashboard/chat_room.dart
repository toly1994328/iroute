import 'package:flutter/material.dart';

class ChatRoom extends StatelessWidget {
  final String? roomId;
  const ChatRoom({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return Material(
      child:  Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('id: ${roomId}',style: TextStyle(fontSize: 32)),
            const SizedBox(height: 16,),
            Text('交流区正在建设中...',style: TextStyle(fontSize: 32),),
          ],
        ),
      ),
    );
  }
}
