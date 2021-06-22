import 'package:flutter/material.dart';
import 'package:flutter_appfood/screens/show_cart.dart';

class MyStyle {
  Color darkColor = Colors.blue.shade500;
  Color primaryColor = Colors.lightGreen.shade300;

  Widget iconShowCart(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add_shopping_cart),
      onPressed: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => ShowCart(),
        );
        Navigator.push(context, route);
      },
    );
  }

  Widget showProgress() {
    return Center(child: CircularProgressIndicator(),);
  }

  TextStyle mainTitle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.purple,
  );

  TextStyle mainH2Title = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.green.shade700,
  );

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


  Text showTitleH3(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.w500,
        ),
      );

  Text showTitleH3White(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      );

  Text showTitleH3Red(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.red.shade900,
          fontWeight: FontWeight.w500,
        ),
      );

  Text showTitleH3Purple(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.purple.shade700,
          fontWeight: FontWeight.w500,
        ),
      );

  MyStyle();
}
