import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Colors.blue.shade500;
  Color primaryColor = Colors.lightGreen.shade300;

  SizedBox mySizedbox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.blue.shade500,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget titleCenter(BuildContext context, String string) {
    return Center(
      child: Container(width: MediaQuery.of(context).size.width*0.5,
        child: Text(
          string,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget showTitleH2(String title) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.blue.shade500,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );

  Container showLogo() {
    return Container(
      width: 120.0,
      child: Image.asset('images/logo.png'),
    );
  }

  BoxDecoration myBoxDecoration(String namePic) {
    return BoxDecoration(
      image: DecorationImage(
          image: AssetImage('images/$namePic'), fit: BoxFit.cover),
    );
  }

  MyStyle();
}
