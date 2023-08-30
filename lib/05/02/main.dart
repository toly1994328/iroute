import 'package:flutter/material.dart';

void main() {
  runApp(const OverlayPage());
}

class OverlayPage extends StatelessWidget{
  const OverlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OverlayEntry home = OverlayEntry(builder: (BuildContext context) => const HomePage());
    final OverlayEntry circle = OverlayEntry(builder: (BuildContext context) => const Center(child:  Circle()));

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Overlay(
        initialEntries: [home,circle],
      ),
    );
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
      decoration: const BoxDecoration(
        color: Colors.redAccent,
        shape: BoxShape.circle
      ),
    );
  }
}
