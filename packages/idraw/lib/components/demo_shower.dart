import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoShower extends StatefulWidget {
  final List<Widget> demos;
   const DemoShower({super.key, required this.demos});

  @override
  State<DemoShower> createState() => _DemoShowerState();
}

class _DemoShowerState extends State<DemoShower> {
  PageController _ctrl = PageController();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView(
          controller: _ctrl,
          children: widget.demos,
        ),

        Positioned(
            bottom: 20,
            child:  Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                TolyIconButton(
                  onTap: (){
                    _index= (_index-1)%widget.demos.length;
                    setState(() {

                    });
                    _ctrl.animateToPage(_index,curve: Curves.easeIn,duration: Duration(milliseconds: 200));
                  },
                  iconData: Icons.navigate_before,
                  size: 36,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text('第 ${_index+1}/${widget.demos.length} 页',style: TextStyle(fontSize: 16,color: Colors.grey),),
                ),

                TolyIconButton(
                  onTap: (){
                    _index= (_index+1)%widget.demos.length;
                    setState(() {

                    });
                    _ctrl.animateToPage(_index,curve: Curves.easeIn,duration: Duration(milliseconds: 200));
                  },
                  size: 36,
                  iconData: Icons.navigate_next,
                ),

              ],
            )),

      ],
    );
  }
}


class TolyIconButton extends StatefulWidget {
  final IconData iconData;
  final VoidCallback onTap;
  final double size;
  const TolyIconButton({
    super.key,
    required this.iconData,
    required this.size, required this.onTap,
  });

  @override
  State<TolyIconButton> createState() => _TolyIconButtonState();
}

class _TolyIconButtonState extends State<TolyIconButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: _onEnter,
        onExit: _onExit,
        cursor: SystemMouseCursors.click,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
              color: _hover?Colors.grey.withOpacity(0.6):Colors.grey.withOpacity(0.5), shape: BoxShape.circle),
          child:  Icon(
            widget.iconData,
            size: 26,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _onEnter(PointerEnterEvent event) {
    setState(() {
      _hover = true;
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _hover = false;
    });
  }
}
