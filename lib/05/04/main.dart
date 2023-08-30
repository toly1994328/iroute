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
  double _left = 0;
  double _top = 0;

  @override
  Widget build(BuildContext context) {
    final OverlayEntry home =
        OverlayEntry(builder: (BuildContext context) => const HomePage());

    final OverlayEntry circle = OverlayEntry(
        builder: (BuildContext context) => Positioned(
              top: 50,
              left: 50,
              child: GestureDetector(
                onPanUpdate: _updatePosition,
                child: const Circle(),
              ),
            ));

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Overlay(
        initialEntries: [home, circle],
      ),
    );
  }

  void _updatePosition(DragUpdateDetails details) {
    setState(() {
      _top += details.delta.dy;
      _left += details.delta.dx;
    });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.white,
      child: Align(
        child: FlutterLogo(
          size: 60,
        ),
      ),
    );
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
