import 'package:flutter/material.dart';

void main() {
  runApp(const OverlayPage());
}

class OverlayPage extends StatefulWidget {
  const OverlayPage({super.key});

  @override
  State<OverlayPage> createState() => _OverlayPageState();
}

class _OverlayPageState extends State<OverlayPage> {
  @override
  Widget build(BuildContext context) {
    final OverlayEntry home = OverlayEntry(builder: (BuildContext context) => const HomePage());
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Overlay(
        initialEntries: [home],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  OverlayEntry? entry;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Align(
        child: GestureDetector(
          onTap: _toggle,
          child: const FlutterLogo(
            size: 60,
          ),
        ),
      ),
    );
  }

  void _toggle() {
    if(entry==null){
      entry = _createPoint();
      Overlay.of(context).insert(entry!);
    }else{
      entry!.remove();
      entry = null;
    }
  }

  OverlayEntry _createPoint() {
    return OverlayEntry(
      builder: (BuildContext context) => Positioned(
        width: 20,
        height: 20,
        left:  20,
        top: 20,
        child: GestureDetector(child: const Circle()),
      ),
    );
  }
}

class ClickShowPage extends StatefulWidget {
  const ClickShowPage({super.key});

  @override
  State<ClickShowPage> createState() => _ClickShowPageState();
}

class _ClickShowPageState extends State<ClickShowPage> {
  Offset _position = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _addPoint,
      onTapDown: _onTapDown,
    );
  }

  void _addPoint() {
    OverlayEntry entry = _createPoint();
    Overlay.of(context).insert(entry);
  }

  OverlayEntry _createPoint() {
    return OverlayEntry(
      builder: (BuildContext context) => Positioned(
          width: 20,
          height: 20,
          left: _position.dx - 10,
          top: _position.dy - 10,
          child: Circle()),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _position = details.localPosition;
  }
}

class Circle extends StatelessWidget {
  const Circle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration:
          const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
    );
  }
}
