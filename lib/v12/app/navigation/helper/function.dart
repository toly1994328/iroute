import 'package:flutter/cupertino.dart';

Map<String, String> kRouteLabelMap = {
  '': '',
  '/color': '颜色板',
  '/color/add': '添加颜色',
  '/color/detail': '颜色详情',
  '/counter': '计数器',
  '/sort': '排序算法',
  '/sort/player': '',
  '/sort/settings': '排序配置',
  '/user': '我的',
  '/settings': '系统设置',
};


String calcRouteName(BuildContext context,String path){
  String? result = kRouteLabelMap[path];
  if(result !=null) return result;
  if(path.startsWith('/sort/player/')){
    return path.split('/sort/player/')[1];
  }

  return '未知路由';
}