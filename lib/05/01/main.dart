import 'package:flutter/material.dart';

void main() {
  runApp(const OverlayPage());
}

class OverlayPage extends StatelessWidget{
  const OverlayPage({super.key});

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.white,
      child: Align(
        child: FlutterLogo(size: 60,),
      ),
    );
  }
}

