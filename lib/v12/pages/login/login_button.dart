import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app/authentication/auth_scope.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onLogin;
  const LoginButton({super.key, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    AuthResult authResult = AuthScope.of(context);
    VoidCallback? action;
    Widget child;
    switch (authResult.status) {
      case AuthStatus.none:
      case AuthStatus.success:
      case AuthStatus.failed:
      case AuthStatus.waitingLoginOut:
        action = onLogin;
        child = const Text('登 录', style: style);
        break;
      case AuthStatus.waitingLogin:
        action = null;
        child = const Wrap(
          spacing: 8,
          children: [
            CupertinoActivityIndicator(radius: 10),
            Text('登录中...', style: style)
          ],
        );
    }

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(), minimumSize: const Size(320, 52)),
        onPressed: action,
        child: child);
  }
}
