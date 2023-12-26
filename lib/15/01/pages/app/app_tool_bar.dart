import 'package:flutter/material.dart';
import '../../main.dart';

class AppToolBar extends StatefulWidget implements PreferredSizeWidget{
  const AppToolBar({super.key});

  @override
  State<AppToolBar> createState() => _AppToolBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppToolBarState extends State<AppToolBar> {

  TextEditingController _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _changRoute();
    router.addListener(_changRoute);
  }

  @override
  void dispose() {
    router.removeListener(_changRoute);
    _ctrl.dispose();
    super.dispose();
  }

  void _changRoute() {
    _ctrl.text= router.value.join(',');
  }

  @override
  Widget build(BuildContext context) {

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title : TextField(
        controller: _ctrl,
        onSubmitted: _onSubmitted,
        decoration: InputDecoration( //装饰
            filled: true, //填充
            fillColor: Color(0xffF3F6F9), //填充颜色
            constraints: BoxConstraints(maxHeight: 34), //约束信息
            contentPadding: EdgeInsets.only(top: -14,left: 10),
            border: UnderlineInputBorder( //边线信息
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            hintText: "请输入路由", //提示字
            hintStyle: TextStyle(fontSize: 14) //提示字样式
        ),
      ),
    );
  }

  void _onSubmitted(String value) {
    router.value = value.split(',');
  }
}
