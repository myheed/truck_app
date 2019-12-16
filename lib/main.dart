import 'package:flutter/material.dart';
import 'index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/register",  // 默认路由为首页
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes:{
        "/register": (context) => Register(),
        "/": (context) => HomePage(), //注册首页路由
      },
    );
  }
}

