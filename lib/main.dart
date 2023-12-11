import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

import 'navigation/app_navigation.dart';
import 'v12/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setSize();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(TolyBooksApp());
}


void setSize() async{
  if(kIsWeb||Platform.isAndroid||Platform.isIOS) return;
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1024, 1024*3/4),
      minimumSize: Size(600, 400),
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
