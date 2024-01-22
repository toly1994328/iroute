import 'dart:ffi';

import 'package:flutter/material.dart';

import '../navigation/left_navigation/left_router_delegate.dart';
import '../navigation/right_navigation/right_router_delegate.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            leftRouterDelegate.value = '/home';
            rightRouterDelegate.value = '/detail?id=${widget.id}';
          },
        ),
        title: Text('商品详情'),),
      body: Center(child: Column(
        children: [
          Text('商品${widget.id}'),
          const SizedBox(height: 30,),
          Text('这是商品${widget.id}的详细信息\n'*10),
          ElevatedButton(onPressed: (){
            leftRouterDelegate.value =  '/detail?id=${widget.id}';
            rightRouterDelegate.value =  '/detail?id=100';
          }, child: Text('推荐 100'))
        ],
      ),),
    );
  }
}
