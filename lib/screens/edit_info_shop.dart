import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appfood/model/user_model.dart';
import 'package:flutter_appfood/utility/my_style.dart';
import 'package:flutter_appfood/utility/normal_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditInfoShop extends StatefulWidget {
  @override
  _EditInfoShopState createState() => _EditInfoShopState();
}

class _EditInfoShopState extends State<EditInfoShop> {
  UserModel userModel;
  String nameShop, address, phone, urlPicture;
  Location location = Location();
  double lat, lng;
  File file;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    readCurrentInfo();

    location.onLocationChanged.listen((event) {
      setState(() {
        lat = event.latitude;
        lng = event.longitude;
        print('lat = $lat, lng = $lng');
      });
    });
  }

  Future<Null> readCurrentInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idShop = preferences.getString('id');
    print('idShop ==>> $idShop');

    String url =
        'http://localhost/FlutterFood/getUserWhereId.php?isAdd=true&id=$idShop';

    Response response = await Dio().get(url);
    print('response ==>> $response');

    var result = json.decode(response.data);
    print('result ==>> $result');

    for (var map in result) {
      print('map ==>> $map');

      setState(() {
        userModel = UserModel.fromJson(map);
        nameShop = userModel.nameShop;
        address = userModel.address;
        phone = userModel.phone;
        urlPicture = userModel.urlPicture;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ปรับปรุงรายละเอียดร้าน'),
      ),
      body: userModel == null ? MyStyle().showProgress() : showContent(),
    );
  }

  Widget showContent() => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            nameShopForm(),
            showImage(),
            addressForm(),
            phoneForm(),
            lat == null ? MyStyle().showProgress() : showmap(),
            editButton(),
          ],
        ),
      );

  Widget editButton() => Container(
        width: MediaQuery.of(context).size.width,
        child: RaisedButton.icon(
          color: MyStyle().primaryColor,
          onPressed: () => confirmDialog(),
          icon: Icon(Icons.edit),
          label: Text('Save Edit'),
        ),
      );

  Future<Null> confirmDialog() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('ปรุบปรุงข้อมูล'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                onPressed: () {
                  Navigator.pop(context);
                  editThread();
                },
                child: Text('OK'),
              ),
              OutlineButton(
                onPressed: () => Navigator.pop(context),
                child: Text('cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<Null> editThread() async {
    String id = userModel.id;
    print('id = $id');

    String url =
        'http://localhost/FlutterFood/editDataWhereId.php?isAdd=true&id=$id&NameShop=$nameShop&Address=$address&Phone=$phone&UrlPicture=$urlPicture&Lat=$lat&Lng=$lng';

    Response response = await Dio().get(url);
    if (response.toString() == 'true') {
      Navigator.pop(context);
    } else {
      normolDialog(context, 'กรุณาลองใหม่ค่ะ');
    }
  }

  Set<Marker> currentMaker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('myMarker'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
            title: 'ร้านของคุณอยู่ที่นี่', snippet: 'lat = $lat, lng = $lng'),
      )
    ].toSet();
  }

  Container showmap() {
    CameraPosition cameraProsition = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 16.0,
    );

    return Container(
      margin: EdgeInsets.only(top: 16.0),
      height: 250.0,
      child: GoogleMap(
        initialCameraPosition: cameraProsition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: currentMaker(),
      ),
    );
  }

  Widget showImage() => Container(
        margin: EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: () => getImageCa(),
            ),
            Container(
              width: 250.0,
              height: 200.0,
              child: file == null ? Image.network('http://localhost$urlPicture') : Image.file(file) ,
            ),
            IconButton(
              icon: Icon(Icons.add_photo_alternate),
              onPressed: () => getImageGa(),
            ),
          ],
        ),
      );

  Future getImageCa() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageGa() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget nameShopForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => nameShop = value,
              initialValue: nameShop,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ชื่อร้าน',
              ),
            ),
          ),
        ],
      );

  Widget addressForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => address = value,
              initialValue: address,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ที่อยู่ร้าน',
              ),
            ),
          ),
        ],
      );

  Widget phoneForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => phone = value,
              initialValue: phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'เบอร์ติดต่อร้าน',
              ),
            ),
          ),
        ],
      );
}
