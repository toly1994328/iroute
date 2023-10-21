import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'app/unit_app.dart';
import 'app/navigation/router/app_router_delegate.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setSize();
  runApp(const UnitApp());
}


void setSize() async{
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 540),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}
