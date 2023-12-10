import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iroute/v12/app/authentication/auth_scope.dart';

import '../login/logout_button.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? name = AuthScope.of(context).name;
    int? coin = AuthScope.of(context).coin;
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                child: FlutterLogo(),
              ),
              const SizedBox(width: 12,),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$name',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 4,),
                  Text('金币: ${coin}',style: TextStyle(fontSize: 12,color: Colors.grey,),)
                ],
              ),
              Spacer(),
              LogoutButton(
                onLogout: () async {
                 bool success = await AuthScope.of(context).logout();
                 if(success){
                   context.go('/');
                 }
                },
              )
            ],
          ),
        )
    );
  }
}
