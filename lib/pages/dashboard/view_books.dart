import 'package:flutter/material.dart';

import 'view_book/book_cell.dart';
import 'view_book/title_group.dart';

class BookInfo {
  final String name;
  final String path;
  final String url;
  final String price;
  final String info;
  final String cover;

  BookInfo({
    required this.name,
    required this.path,
    required this.url,
    required this.price,
    required this.info,
    required this.cover,
  });
}

List<BookInfo> kBooks = [
  BookInfo(
    name: 'Flutter语言基础·梦始之地',
    path: 'dream',
    url: 'https://juejin.cn/book/6844733827617652750',
    info: '从语法到思想，欢迎来到 Flutter 梦开始的地方',
    cover: 'assets/images/dream.webp',
    price: '3.5',
  ),
  BookInfo(
    name: 'Flutter绘制指南·妙笔生花',
    path: 'draw',
    url: 'https://juejin.cn/book/6844733827265331214',
    info: '带你见证 Flutter 的绘制之美，擦出创造的火花',
    cover: 'assets/images/draw.webp',
    price: '3.28',
  ),
  BookInfo(
    name: 'Flutter布局探索·薪火相传',
    path: 'layout',
    url: 'https://juejin.cn/book/7075958265250578469',
    info: '由浅入深，从源码探索 Flutter 布局原理',
    cover: 'assets/images/layout.webp',
    price: '3.5',
  ),
  BookInfo(
    name: 'Flutter手势探索·执掌天下',
    path: 'touch',
    url: 'https://juejin.cn/book/6896378716427911181',
    info: 'Flutter 手势探索，用你的手指，掌控着整个屏幕世界 ',
    cover: 'assets/images/touch.webp',
    price: '3.5',
  ),
  BookInfo(
    name: 'Flutter滑动探索·珠联璧合',
    path: 'scroll',
    url: 'https://juejin.cn/book/6984685333312962573',
    info: '从源码入手，带你深入探索 Flutter 滑动体系',
    price: '3.5',
    cover: 'assets/images/scroll.webp',
  ),
  BookInfo(
    name: 'Flutter动画探索·流光幻影',
    path: 'anima',
    url: 'https://juejin.cn/book/6965102582473687071',
    info: 'Flutter 动画探索，一起去见证 Flutter 动画的风采',
    cover: 'assets/images/anima.webp',
    price: '3.5',
  ),

  BookInfo(
    name: 'Flutter渲染机制·聚沙成塔',
    path: 'dream',
    url: 'https://juejin.cn/book/7084139149673889805',
    info: '全面探索框架源码，助你攀登九层之台，一览顶上风采',
    price: '3.5',
    cover: 'assets/images/render.webp',
  ),
];
List<BookInfo> freeBooks = [
  BookInfo(
    name: 'Flutter 入门教程',
    path: 'first',
    url: 'https://juejin.cn/book/7212822723330834487',
    info: '以有趣的案例为基础，带你入门 Flutter 技术',
    cover: 'assets/images/first.webp',
    price: '0',
  ),
];

List<BookInfo> projectBooks = [
  BookInfo(
    name: 'Flutter 实战：正则匹配应用',
    path: 'regex',
    url: 'https://juejin.cn/book/7161060514377203751',
    info: '从思想分析到实践， Flutter 全平台玩转正则表达式',
    cover: 'assets/images/regex.webp',
    price: '0',
  ),
];


class ViewBooks extends StatelessWidget {
  const ViewBooks({super.key});

  @override
  Widget build(BuildContext context) {
    SliverGridDelegate gridDelegate =
        const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 240,
      mainAxisSpacing: 10,
      mainAxisExtent: 280,
      crossAxisSpacing: 10,
    );
    return CustomScrollView(
      slivers: [

        SliverToBoxAdapter(
          child: TitleGroup(title: 'Flutter 七剑合璧',),
        ),

        SliverGrid(
            delegate: SliverChildBuilderDelegate(
                  (_, i) => BookCell(bookInfo:kBooks[i]),
              childCount: kBooks.length,
            ),
            gridDelegate: gridDelegate),

        SliverToBoxAdapter(
          child: TitleGroup(title: 'Flutter 实战探索',),
        ),


        SliverGrid(
            delegate: SliverChildBuilderDelegate(
                  (_, i) => BookCell(bookInfo:projectBooks[i]),
              childCount: projectBooks.length,
            ),
            gridDelegate: gridDelegate),

        SliverToBoxAdapter(
          child: TitleGroup(title: 'Flutter 免费小册',),
        ),
        SliverGrid(
            delegate: SliverChildBuilderDelegate(
                  (_, i) => BookCell(bookInfo:freeBooks[i]),
              childCount: freeBooks.length,
            ),
            gridDelegate: gridDelegate),
      ],
    );

    // SliverGridDelegate gridDelegate = const SliverGridDelegateWithMaxCrossAxisExtent(
    //   maxCrossAxisExtent: 240,
    //   mainAxisSpacing: 10,
    //   mainAxisExtent: 260,
    //   crossAxisSpacing: 10,
    // );
    // return GridView.builder(
    //   padding: EdgeInsets.all(10),
    //   gridDelegate: gridDelegate,
    //   itemBuilder: (_, i) {
    //     BookInfo bookInfo = kBooks[i];
    //     return Center(
    //       child: Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Expanded(child: Center(child: Image.asset(bookInfo.cover))),
    //             const SizedBox(height: 6,),
    //             Text('${bookInfo.name}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
    //             const SizedBox(height: 6,),
    //             Text('${bookInfo.info}',style: TextStyle(fontSize: 12,color: Color(0xff515767)),),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    //   itemCount: kBooks.length,
    // );
  }
}
