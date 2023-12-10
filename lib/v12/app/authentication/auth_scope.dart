import 'package:flutter/material.dart';

const Map<String,String> _kTestUserMap = {
  'toly': '123456',
  '张风捷特烈': '111111',
  'test1': '111111',
};

class AuthScope extends InheritedNotifier<AuthResult> {
  const AuthScope({super.key, required super.child, super.notifier});

  static AuthResult of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AuthScope>()!
        .notifier!;
  }

  static AuthResult read(BuildContext context) {
    return context
        .getInheritedWidgetOfExactType<AuthScope>()!
        .notifier!;
  }
}

enum AuthStatus{
  none,
  success,
  failed,
  waitingLogin,
  waitingLoginOut,
}

class AuthResult with ChangeNotifier {
  String? name;
  int coin = 0;
  String? token;
  AuthStatus status = AuthStatus.none;

  AuthResult();

  Future<(bool,String)> login(String username,String pwd) async{
    /// 模拟校验 与 模拟延时
    bool allow = _kTestUserMap[username] == pwd;
    status = AuthStatus.waitingLogin;
    notifyListeners();
      await Future.delayed(const Duration(seconds: 1));
    if(allow){
      name = username;
      coin = 1994328;
      token = 'testToken======';
      status = AuthStatus.success;
      notifyListeners();
      return (true,'登陆成功!');
    }else{
      /// 可以返回一写其他错误信息
      status = AuthStatus.failed;
      notifyListeners();
      return (false,'登陆失败!');
    }
  }

  Future<bool> logout() async{
    status = AuthStatus.waitingLoginOut;
    notifyListeners();
    /// 模拟退出登录请求耗时
    await Future.delayed(const Duration(seconds: 1));
    name = null;
    coin = 0;
    token = null;
    status = AuthStatus.none;
    notifyListeners();
    return true;
  }
}

