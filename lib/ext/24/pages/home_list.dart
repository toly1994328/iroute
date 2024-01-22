import 'dart:ffi';

import 'package:flutter/material.dart';

import '../navigation/right_navigation/right_router_delegate.dart';

class HomeListPage extends StatefulWidget {
  const HomeListPage({super.key});

  @override
  State<HomeListPage> createState() => _HomeListPageState();
}

class _HomeListPageState extends State<HomeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('商品列表'),),
      body: ListView.builder(itemBuilder: (_,index)=>ListTile(
        onTap: ()=>_onTap(index),
        title: Text('商品$index'),
      )),
    );
  }

  void _onTap(int index) {
    rightRouterDelegate.value = '/detail?id=$index';
  }
}
