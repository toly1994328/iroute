import 'package:flutter/material.dart';

class NotFindPage extends StatelessWidget {
  const NotFindPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Material(
      child: Center(
            child: Wrap(
              spacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              children: [
                Icon(Icons.nearby_error,size: 64, color: Colors.redAccent),
                Text(
                  '404 Page Not Find',
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ),
              ],
            ),
      ),
    );
  }
}
