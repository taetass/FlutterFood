import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appfood/utility/my_style.dart';
import 'package:flutter_appfood/utility/normal_dialog.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String chooseType, name, user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[
              Colors.white,
              MyStyle().primaryColor,
            ],
            center: Alignment(0, -0.8),
            radius: 1.0,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            myLogo(),
            showAppName(),
            MyStyle().mySizedbox(),
            nameForm(),
            MyStyle().mySizedbox(),
            userForm(),
            MyStyle().mySizedbox(),
            passwordForm(),
            MyStyle().mySizedbox(),
            MyStyle().showTitleH2('เลือกประเภทที่ต้องการสมัครสมาชิก:'),
            userRadio(),
            shopRadio(),
            riderRadio(),
            registerButton(),
          ],
        ),
      ),
    );
  }

  Widget registerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250.0,
          child: RaisedButton(
            color: MyStyle().darkColor,
            onPressed: () {
              print(
                  'name = $name, user = $user, password = $password, chooseType = $chooseType');
              if (name == null ||
                  name.isEmpty ||
                  user == null ||
                  user.isEmpty ||
                  password == null ||
                  password.isEmpty) {
                    print('Have Space');
                    normolDialog(context, 'กรุณากรอกให้ครบทุกช่องค่ะ');
                  } else if (chooseType == null) {
                    normolDialog(context, 'กรุณาเลือกประเภทที่ต้องการสมัคร');
                  } else {
                    checkUser();
                  }
            },
            child: Text(
              'Register',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
  Future<Null> checkUser() async{
    String url = 'http://localhost/FlutterFood/getUserWhereUser.php?isAdd=true&User=$user';
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        registerThread();
      } else {
        normolDialog(context, 'user $user ถูกนำมาใช้แล้ว กรุณาใช้ user ใหม่ค่ะ');
      }
    } catch (e) {
    }
  }

  Future<Null> registerThread() async{
    String url = 'http://localhost/FlutterFood/addUser.php?isAdd=true&Name=$name&User=$user&Password=$password&ChooseType=$chooseType';

    try {
      Response response = await Dio().get(url);
      print('res = $response');

      if (response.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normolDialog(context, 'ไม่สามารถสมัครได้ กรุณาลองใหม่ค่ะ');
      }
    } catch (e) {
    }
  }

  Widget userRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 250.0,
            child: Row(
              children: <Widget>[
                Radio(
                  value: 'User',
                  groupValue: chooseType,
                  onChanged: (value) {
                    setState(() {
                      chooseType = value;
                    });
                  },
                ),
                Text(
                  'ผู้สั่งอาหาร',
                  style: TextStyle(color: MyStyle().darkColor),
                ),
              ],
            ),
          ),
        ],
      );

  Widget shopRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 250.0,
            child: Row(
              children: <Widget>[
                Radio(
                  value: 'Shop',
                  groupValue: chooseType,
                  onChanged: (value) {
                    setState(() {
                      chooseType = value;
                    });
                  },
                ),
                Text(
                  'เจ้าของร้านอาหาร',
                  style: TextStyle(color: MyStyle().darkColor),
                ),
              ],
            ),
          ),
        ],
      );

  Widget riderRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 250.0,
            child: Row(
              children: <Widget>[
                Radio(
                  value: 'Rider',
                  groupValue: chooseType,
                  onChanged: (value) {
                    setState(() {
                      chooseType = value;
                    });
                  },
                ),
                Text(
                  'ผู้ส่งอาหาร',
                  style: TextStyle(color: MyStyle().darkColor),
                ),
              ],
            ),
          ),
        ],
      );

  Row showAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyStyle().showTitle('Flutter food'),
      ],
    );
  }

  Widget myLogo() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyStyle().showLogo(),
        ],
      );

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => name = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.face,
                  color: MyStyle().darkColor,
                ),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'Name',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyStyle().darkColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyStyle().primaryColor),
                ),
              ),
            ),
          ),
        ],
      );

  Widget userForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => user = value.trim(),
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
          ),
        ],
      );

  Widget passwordForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => password = value.trim(),
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
          ),
        ],
      );
}
