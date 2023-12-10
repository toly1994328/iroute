import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iroute/components/toly_ui/button/hover_icon_button.dart';
// import '../../router/app_router_delegate.dart';

class AppRouterEditor extends StatefulWidget {
  final ValueChanged<String>? onSubmit;
  const AppRouterEditor({super.key, this.onSubmit});

  @override
  State<AppRouterEditor> createState() => _AppRouterEditorState();
}

class _AppRouterEditorState extends State<AppRouterEditor> {

  final TextEditingController _controller = TextEditingController();
  late GoRouterDelegate _delegate ;


  @override
  void initState() {
    super.initState();
    _delegate =   GoRouter.of(context).routerDelegate;

    _onRouteChange();
    _delegate.addListener(_onRouteChange);
  }

  void _onRouteChange() {

    List<RouteMatch> matches = _delegate.currentConfiguration.matches;
    if(matches.isEmpty) return;
    RouteMatch match = matches.last;
    if(match is ImperativeRouteMatch){
      _controller.text = match.matches.uri.toString();
    }else{
      _controller.text = match.matchedLocation;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _delegate.removeListener(_onRouteChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
