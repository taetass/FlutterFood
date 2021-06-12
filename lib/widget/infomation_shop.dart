import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appfood/model/user_model.dart';
import 'package:flutter_appfood/screens/add_info_shop.dart';
import 'package:flutter_appfood/screens/edit_info_shop.dart';
import 'package:flutter_appfood/utility/my_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfomationShop extends StatefulWidget {
  @override
  _InfomationShopState createState() => _InfomationShopState();
}

class _InfomationShopState extends State<InfomationShop> {
  UserModel userModel;

  @override
  void initState() {
    super.initState();
    readDataUser();
  }

  Future<Null> readDataUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');

    String url =
        'http://localhost/FlutterFood/getUserWhereId.php?isAdd=true&id=$id';
    await Dio().get(url).then((value) {
      //print('value = $value');
      var result = json.decode(value.data);
      //print('result = $result');
      for (var map in result) {
        setState(() {
          userModel = UserModel.fromJson(map);
        });
        print('nameShop = ${userModel.nameShop}');
        if (userModel.nameShop.isEmpty) {}
      }
    });
  }

  void routeToAddInfo() {
    Widget widget = userModel.nameShop.isEmpty ? AddInfoShop() : EditInfoShop() ;
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
      builder: (context) => widget,
    );
    Navigator.push(context, materialPageRoute).then((value) => readDataUser());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        userModel == null
            ? MyStyle().showProgress()
            : userModel.nameShop.isEmpty
                ? showNoData(context)
                : showListInfoShop(),
        addAndEditButton(),
      ],
    );
  }

  Widget showListInfoShop() => Column(
        children: <Widget>[
          MyStyle().showTitleH2(
            'รายละเอียดร้าน ${userModel.nameShop}',
          ),
          Container(
            width: 250.0,
            height: 200.0,
            child: Image.network('http://localhost/${userModel.urlPicture}'),
          ),
          MyStyle().showTitleH2(
            'ที่อยู่ของร้าน',
          ),
          Text(userModel.address),
          MyStyle().mySizedbox(),
          showMap(),
        ],
      );

  Set<Marker> shopMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('shopID'),
        position: LatLng(
          double.parse(userModel.lat),
          double.parse(userModel.lng),
        ),
        infoWindow: InfoWindow(
          title: 'ตำแหน่งร้าน',
          snippet: 'ละติจูต = ${userModel.lat}, ลองติจูด = ${userModel.lng}',
        ),
      )
    ].toSet();
  }

  Widget showMap() {
    double lat = double.parse(userModel.lat);
    double lng = double.parse(userModel.lng);

    LatLng latLng = LatLng(lat, lng);
    CameraPosition position = CameraPosition(target: latLng, zoom: 16.0);

    return Container(
      padding: EdgeInsets.all(10.0),
      height: 300.0,
      child: GoogleMap(
        initialCameraPosition: position,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: shopMarker(),
      ),
    );
  }

  Widget showNoData(BuildContext context) =>
      MyStyle().titleCenter(context, 'ยังไม่มีข้อมูล กรุณาเพิ่มข้อมูลค่ะ');

  Row addAndEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                right: 16.0,
                bottom: 16.0,
              ),
              child: FloatingActionButton(
                  child: Icon(Icons.edit),
                  onPressed: () {
                    routeToAddInfo();
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
