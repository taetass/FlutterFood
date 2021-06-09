import 'package:flutter/material.dart';
import 'package:flutter_appfood/utility/my_style.dart';
import 'package:flutter_appfood/utility/signout_process.dart';
import 'package:flutter_appfood/widget/infomation_shop.dart';
import 'package:flutter_appfood/widget/list_food_menu_shop.dart';
import 'package:flutter_appfood/widget/order_list_shop.dart';

class MainShop extends StatefulWidget {
  @override
  _MainShopState createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {

  Widget currentWidget = OrderListShop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Shop'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => signOutProcess(context),
          ),
        ],
      ),
      drawer: showDrawer(),
      body: currentWidget,
    );
  }
  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHead(),
            homeMenu(),
            foodMenu(),
            infomationMenu(),
            signOutMenu()
          ],
        ),
      );

  ListTile homeMenu() => ListTile(
        leading: Icon(Icons.fastfood),
        title: Text('รายการอาหารที่ลูกค้าสั่ง'),
        onTap: () {
          setState(() {
            currentWidget = OrderListShop();
          });
          Navigator.pop(context);
        }
      );

ListTile foodMenu() => ListTile(
        leading: Icon(Icons.food_bank),
        title: Text('รายการอาหาร'),
        onTap: () {
          setState(() {
            currentWidget = ListFoodMenuShop();
          });
          Navigator.pop(context);
        },
      );

ListTile infomationMenu() => ListTile(
        leading: Icon(Icons.info_outline),
        title: Text('รายละเอียดร้าน'),
        onTap: () {
          setState(() {
            currentWidget = InfomationShop();
          });
          Navigator.pop(context);
        },
      );

ListTile signOutMenu() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Sign Out'),
        subtitle: Text('กลับสู่หน้าหลัก'),
        onTap: () => signOutProcess(context),
      );


  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBoxDecoration('draw2.jpg'),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text(
        'Name login',
        style: TextStyle(color: MyStyle().darkColor),
      ),
      accountEmail: Text(
        'Login',
        style: TextStyle(color: MyStyle().primaryColor),
      ),
    );
  }
}
