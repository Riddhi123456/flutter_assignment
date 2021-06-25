import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_task/src/base/BaseState.dart';
import 'package:flutter_task/src/data/DatabaseHelper.dart';
import 'package:flutter_task/src/models/UserModel.dart';
import 'package:flutter_task/src/resources/CommonColor.dart';
import 'package:flutter_task/src/resources/Strings.dart';
import 'package:flutter_task/src/utils/Utils.dart';
import 'package:flutter_task/src/widget/BigButtonView.dart';
import 'package:flutter_task/src/widget/ToolBar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  final String email;

  const HomeScreen({Key key, this.email}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenState();
  }
}

class HomeScreenState extends BaseState<HomeScreen> {
  CameraPosition _cameraPosition;
  GoogleMapController _controller;

  Set<Marker> _markers = {};
  Position location;
  UserModel user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraPosition = CameraPosition(target: LatLng(0, 0), zoom: 10.0);
    getUserLocation();
  }

  @override
  Widget getBuildWidget(BuildContext context) {
    // TODO: implement getBuildWidget
    return Container(
      child: Column(
        children: [
          Expanded(
            child: (location != null)
                ? GoogleMap(
                    initialCameraPosition: _cameraPosition,
                    mapType: MapType.normal,
                    onMapCreated: (GoogleMapController controller) {
                      _controller = (controller);
                      setMarkerOnCurrentPosition();
                    },
                    markers: _markers,
                    myLocationEnabled: true,
                  )
                : Container(),
          ),
          bigButtonView(
              margin: EdgeInsets.only(right: 10, left: 10, top: 20, bottom: 20),
              label: Strings.secondScreen,
              isEnabled: true,
              onClick: () {
                Navigator.of(context).pushNamed('/second');
              },
              enableColor: CommonColor.red,
              padding: EdgeInsets.only(left: 20, right: 20)),
        ],
      ),
    );
  }

  void getUserLocation() async {
    location = await getLocation();
    if (location != null) {
      setState(() {
        print(location.latitude);
        print(location.longitude);
      });
    } else {
      showSnackBar(Strings.error_getting_location);
    }
  }

  void setMarkerOnCurrentPosition() {
    if (_controller != null)
      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(location.latitude, location.longitude),
        zoom: 15.0,
      )));

    _markers.add(Marker(
      markerId: MarkerId("a"),
      position: LatLng(location.latitude, location.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ));
    setState(() {});
  }

  @override
  AppBar getToolBar(BuildContext context) {
    // TODO: implement getToolBar
    return user!=null?toolBarWithoutLeadingIcon(
      toolBarTitle: user.name,
      toolBarTitleColor: CommonColor.white,
      isImageTitle: true,
      toolBarBgColor: CommonColor.red,
      imagePath: user.image!=null?new File(user.image)
        :'assets/images/profile_dummy.jpg'
    ):null;
  }

  @override
  void onScreenReady(BuildContext context) async{
    // TODO: implement onScreenReady
    user = await DatabaseHelper().getUserDetails(widget.email);
    setState(() {});
  }
}
