import 'package:flutter/material.dart';
import '../index.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: RegisterPage(title: '注册/登陆'),
    );
  }
}

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyRegisterPageState createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<RegisterPage> {
  Dio dio = Dio();
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("注册/登陆"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          autovalidate: true, //开启自动校验
          child: Column(
            children: <Widget>[
              TextFormField(
                  autofocus: true,
                  controller: _unameController,
                  decoration: InputDecoration(
                      labelText: "手机号",
                      hintText: "请输入手机号",
                      icon: Icon(Icons.phone_iphone)
                  ),
                  // 校验用户名
                  validator: (v) {
                    return v.trim().length > 0 ? null : "手机号不符合规范";
                  }
              ),
              TextFormField(
                  controller: _pwdController,
                  decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "您的登录密码",
                      icon: Icon(Icons.lock)
                  ),
                  obscureText: true,
                  //校验密码
                  validator: (v) {
                    return v.trim().length > 5 ? null : "密码不能少于6位";
                  }
              ),
              // 登录按钮
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("登录"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          print('账号' + _unameController.text);
                          print('密码' + _pwdController.text);
                          // 通过_formKey.currentState 获取FormState后，
                          // 调用validate()方法校验用户名密码是否合法，校验通过后再提交数据。
                          if((_formKey.currentState as FormState).validate()){
                            print('get in');
                            //验证通过提交数据
                            _get() async {
                              Response response;
                              var url = 'http://10.0.2.2:3000/users/login';
                              var param = {
                                'phoneNum': _unameController.text,
                                'password': _pwdController.text
                              };
                              response = await dio.post(url, data: param);
                              print(response);
                            }
                            _get();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}