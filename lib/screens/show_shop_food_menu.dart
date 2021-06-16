import 'package:flutter/material.dart';
import 'package:flutter_appfood/model/user_model.dart';
import 'package:flutter_appfood/utility/my_style.dart';

class ShowShopFoodMenu extends StatefulWidget {
  final UserModel userModel;
  ShowShopFoodMenu({Key key, this.userModel}) : super(key: key);

  @override
  _ShowShopFoodMenuState createState() => _ShowShopFoodMenuState();
}

class _ShowShopFoodMenuState extends State<ShowShopFoodMenu> {
  UserModel userModel;

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[],
        title: Text(userModel.nameShop),
      ),
    );
  }
}
