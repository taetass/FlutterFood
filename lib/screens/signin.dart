import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appfood/model/user_model.dart';
import 'package:flutter_appfood/screens/main_rider.dart';
import 'package:flutter_appfood/screens/main_shop.dart';
import 'package:flutter_appfood/screens/main_user.dart';
import 'package:flutter_appfood/utility/const.dart';
import 'package:flutter_appfood/utility/my_style.dart';
import 'package:flutter_appfood/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  String user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[
              Colors.white,
              MyStyle().primaryColor,
            ],
            center: Alignment(0, -0.3),
            radius: 1.0,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyStyle().showLogo(),
                MyStyle().showTitle('Flutter food'),
                MyStyle().mySizedbox(),
                userForm(),
                MyStyle().mySizedbox(),
                passwordForm(),
                MyStyle().mySizedbox(),
                loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return Container(
      width: 250.0,
      child: RaisedButton(
        color: MyStyle().darkColor,
        onPressed: () {
          if (user == null || user.isEmpty || password == null || password.isEmpty) {
            normolDialog(context, 'กรุณากรกข้อมูลให้ครบค่ะ');
          } else {
            checkAuthen();
          }
        },
        child: Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<Null> checkAuthen() async{
    String url = 'http://localhost/FlutterFood/getUserWhereUser.php?isAdd=true&User=$user';
    Response response = await Dio().get(url);
    print('res = $response');

    var result = json.decode(response.data);
    print('result = $result');
    for (var map in result) {
      UserModel userModel = UserModel.fromJson(map);
      if (password == userModel.password) {
        String chooseType = userModel.chooseType;
        if (chooseType == 'User') {
          routeTuService(MainUser(), userModel);
        } else if (chooseType == 'Shop') {
          routeTuService(MainShop(), userModel);
        } else if (chooseType == 'Rider') {
          routeTuService(MainRider(), userModel);
        } else {
          normolDialog(context, 'Error');
        }
        
      } else {
        normolDialog(context, 'password ผิดกรุณาลองใหม่');
      }
    }
  }

  Future<Null> routeTuService(Widget myWidget, UserModel userModel) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(MyConstant().keyId, userModel.id);
    preferences.setString(MyConstant().keyType, userModel.chooseType);
    preferences.setString(MyConstant().keyName, userModel.name);

    MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget userForm() => Container(
        width: 250.0,
        child: TextField(onChanged: (value) => user = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().darkColor,
            ),
            labelStyle: TextStyle(color: MyStyle().darkColor),
            labelText: 'User',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().darkColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().primaryColor),
            ),
          ),
        ),
      );

  Widget passwordForm() => Container(
        width: 250.0,
        child: TextField(onChanged: (value) => password = value.trim(),
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: MyStyle().darkColor,
            ),
            labelStyle: TextStyle(color: MyStyle().darkColor),
            labelText: 'Password',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().darkColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().primaryColor),
            ),
          ),
        ),
      );
}
