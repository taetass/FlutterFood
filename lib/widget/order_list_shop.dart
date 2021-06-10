import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appfood/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderListShop extends StatefulWidget {
  @override
  _OrderListShopState createState() => _OrderListShopState();
}

class _OrderListShopState extends State<OrderListShop> {

  UserModel userModel;

  @override
  void initState() { 
    super.initState();
    
  }

  


  @override
  Widget build(BuildContext context) {
    return Text(
      'รายการอาหารที่ลูกค้าสั่ง'
    );
  }
}