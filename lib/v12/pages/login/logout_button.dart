import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iroute/v12/app/authentication/auth_scope.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onLogout;
  const LogoutButton({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    AuthResult authResult = AuthScope.of(context);
    VoidCallback? action = onLogout;
    Widget child = const Icon(Icons.logout,size: 20,);
    switch (authResult.status) {
      case AuthStatus.none:
      case AuthStatus.success:
      case AuthStatus.failed:
      case AuthStatus.waitingLogin:
        break;
      case AuthStatus.waitingLoginOut:
        action = null;
        child = CupertinoActivityIndicator(radius: 10,);
    }

    return  IconButton(
      splashRadius: 20,
      onPressed: action,
      tooltip: '退出登录',
      icon: child,
    );
  }
}
