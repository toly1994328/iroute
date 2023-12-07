import 'package:flutter/material.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    const String msg = 'FlutterUnit 是一个辅助开发者,了解 Flutter 组件和编程技术的开源项目。 ';
    const String msg2 = '由张风捷特烈维护，开源地址:\n https://github.com/toly1994328/FlutterUnit ';

    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height*(1-0.618),
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: Align(child: FlutterLogo()),
            actions: [
              CloseButton()
            ],
            title: Column(
              children: [
                Text('FlutterUnit',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                Text('v2.9.3',style: TextStyle(fontSize: 12,),),
              ],
            ),),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // direction: Axis.vertical,
              children: [
                Text(msg,style: TextStyle(color: Colors.grey),),
                const SizedBox(height: 8,),
                Text(msg2,style: TextStyle(color: Colors.grey),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
