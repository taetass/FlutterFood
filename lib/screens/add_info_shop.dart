import 'package:flutter/material.dart';
import 'package:flutter_appfood/utility/my_style.dart';

class AddInfoShop extends StatefulWidget {
  @override
  _AddInfoShopState createState() => _AddInfoShopState();
}

class _AddInfoShopState extends State<AddInfoShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Infomation Shop'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MyStyle().mySizedbox(),
            nameForm(),
            MyStyle().mySizedbox(),
            addressForm(),
            MyStyle().mySizedbox(),
            phonForm(),
            MyStyle().mySizedbox(),
            groupImage(),
            MyStyle().mySizedbox(),
            showMap(),
          ],
        ),
      ),
    );
  }

  Container showMap() {
    return Container(
            height: 300.0,
          );
  }

  Widget groupImage() => Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add_a_photo,
                size: 36.0,
              ),
              onPressed: () {},
            ),
            Container(
              width: 250.0,
              child: Image.asset('images/shop1.png'),
            ),
            IconButton(
              icon: Icon(
                Icons.add_photo_alternate,
                size: 36.0,
              ),
              onPressed: () {},
            ),
          ],
        ),
      );

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'ชื่อร้านค้า',
                prefixIcon: Icon(Icons.account_box),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget addressForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'ที่อยู่ร้านค้า',
                prefixIcon: Icon(Icons.home),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget phonForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'เบอร์ติดต่อร้านค้า',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );
}
