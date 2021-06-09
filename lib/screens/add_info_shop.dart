import 'package:flutter/material.dart';
import 'package:flutter_appfood/utility/my_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AddInfoShop extends StatefulWidget {
  @override
  _AddInfoShopState createState() => _AddInfoShopState();
}

class _AddInfoShopState extends State<AddInfoShop> {

  double lat, lng;
  
  @override
  void initState() { 
    super.initState();
    findLatLng();
  }

  Future<Null> findLatLng() async {
    LocationData locationData = await findLocationData();
    lat = locationData.latitude;
    lng = locationData.longitude;
    print('lat = $lat, lng = $lng');
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }
   
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
            groupImage(),
            showMap(),
            MyStyle().mySizedbox(),
            saveButton(),
          ],
        ),
      ),
    );
  }

  Widget saveButton() {
    return Container(
      margin: EdgeInsets.only(right: 50.0, left: 50.0),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        color: MyStyle().primaryColor,
        onPressed: () {},
        icon: Icon(Icons.save),
        label: Text('Save Infomation'),
      ),
    );
  }

  Container showMap() {
    LatLng latLng = LatLng(13.780529435317023, 100.63833511720829);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );
    return Container(
      margin: EdgeInsets.only(right: 20.0, left: 20.0),
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
      ),
      height: 300.0,
    );
  }

  Widget groupImage() => Container(
        margin: EdgeInsets.only(right: 20.0, left: 20.0),
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
