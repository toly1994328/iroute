import 'package:flutter/material.dart';
import '../../app/navigation/router/app_router_delegate.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Login Page',style: TextStyle(fontSize: 24),),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              router.changePath('/app/color');
            }, child: Text('点击进入'))
          ],
        ),
      ),
    );
  }
}
