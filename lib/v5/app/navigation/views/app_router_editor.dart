import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iroute/components/toly_ui/button/hover_icon_button.dart';
import 'package:iroute/components/toly_ui/popable/drop_selectable_widget.dart';
import 'package:iroute/v5/pages/sort/provider/sort_config.dart';
import '../../../pages/sort/functions.dart';
import '../router/app_router_delegate.dart';

class AppRouterEditor extends StatefulWidget {
  final ValueChanged<String>? onSubmit;
  const AppRouterEditor({super.key, this.onSubmit});

  @override
  State<AppRouterEditor> createState() => _AppRouterEditorState();
}

class _AppRouterEditorState extends State<AppRouterEditor> {

  final TextEditingController _controller = TextEditingController();


  @override
  void initState() {
    super.initState();
    _onRouteChange();
    router.addListener(_onRouteChange);
  }

  void _onRouteChange() {
    _controller.text=router.path;
  }

  @override
  void dispose() {
    _controller.dispose();
    router.removeListener(_onRouteChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return  Row(
      children: [
        DropSelectableWidget(
          fontSize: 12,
          data: sortNameMap.values.toList(),
          iconSize: 20,
          height: 30,
          width: 200,
          disableColor: const Color(0xff1F425F),
          onDropSelected: (int index) async {
sortName.value=sortNameMap.keys.toList()[index];
            // curveAnim = CurvedAnimation(
            //     parent: _ctrl, curve: maps.values.toList()[index]);
            // _startAnim();
          },
        ),
        const SizedBox(width: 10,),
        GestureDetector(
            onTap: (){
              Scaffold.of(context).openEndDrawer();
              // showDialog(
              //     useRootNavigator: false,
              //     context: context, builder: (ctx)=>AlertDialog());
            },
            child: const Icon(Icons.settings))
      ],
    );

    return Stack(
      alignment: Alignment.centerRight,
      children: [
        SizedBox(
          child: CupertinoTextField(
            controller: _controller,
            style: TextStyle(fontSize: 14),
            padding: EdgeInsets.only(left:12,top: 6,bottom: 6,right: 32),
            placeholder: '输入路由地址导航',
            onSubmitted: widget.onSubmit,
            decoration: BoxDecoration(color: Color(0xffF1F2F3),borderRadius: BorderRadius.circular(6)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: HoverIconButton(
            icon: Icons.directions_outlined,
            defaultColor: Color(0xff68696B),
            onPressed:()=>widget.onSubmit?.call(_controller.text),
            size: 20
          ),
        )
      ],
    );
  }
}
