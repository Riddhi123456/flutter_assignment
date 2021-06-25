import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

void printLog(String msg) {
  assert(() {
    print(msg);
    return true;
  }());
}

Future<bool> isConnected() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}

bool isPhoneNumberValidator(String value) {
  RegExp pattern = new RegExp(r'^[6-9]\d{9}$');
  printLog(pattern.hasMatch(value).toString());
  if (!pattern.hasMatch(value))
    return false;
  else
    return true;
}

Future<File> chooseFile() async {
  File image = await ImagePicker.pickImage(
      source: ImageSource.gallery, imageQuality: 90, maxHeight: 640, maxWidth: 800);
  return image;
}

Future<File> chooseFileFromCamera({String filename}) async {
  File image = await ImagePicker.pickImage(
      source: ImageSource.camera, imageQuality: 90, maxWidth: 640, maxHeight: 800);
  printLog('Original path: ${image.path}');
  String dir = path.dirname(image.path);
  String filenameChanged = filename.replaceAll('/', '');
  String newPath = path.join(
      dir,
      '$filenameChanged'
      '.${getFileExtension(image)}');
  printLog('NewPath: ${newPath}');
  return image.renameSync(newPath);
}

String getFileExtension(File file) {
  List ll = file.path.split('.');
  return ll.elementAt(ll.length - 1);
}

String getFieldValue(Map map, String key) {
  String str = '';
  if (map.containsKey(key)) {
    String s = map[key];
    if (s != null) {
      str = s.toString();
    }
  }
  return str;
}

int getFieldValueInteger(Map map, String key) {
  int value = 0;
  if (map.containsKey(key)) {
    int s = map[key];
    if (s != null) {
      value = s;
    }
  }
  return value;
}

bool checkFileExtension(String filePath) {
  List ll = filePath.split('.');
  bool value = false;
  if (ll.elementAt(ll.length - 1).toString() == "png" ||
      ll.elementAt(ll.length - 1).toString() == "jpg" ||
      ll.elementAt(ll.length - 1).toString() == "jpeg") {
    value = true;
  }
  return value;
}

Future<Position> getLocation() async {
  Position userLocation = new Position();
  LocationPermission hasLocationPermission = await GeolocatorPlatform.instance.checkPermission();

  if (hasLocationPermission == LocationPermission.always ||
      hasLocationPermission == LocationPermission.whileInUse) {
    try {
      Position location = await GeolocatorPlatform.instance.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best, timeLimit: Duration(seconds: 20));
      if (location != null) {
        userLocation = new Position();
        userLocation = location;
      } else {
        userLocation = null;
      }
    } catch (err) {
      userLocation = null;
    }
  } else {
    hasLocationPermission = await GeolocatorPlatform.instance.requestPermission();

    if (hasLocationPermission == LocationPermission.whileInUse ||
        hasLocationPermission == LocationPermission.always) {
      try {
        Position location = await GeolocatorPlatform.instance.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best, timeLimit: Duration(seconds: 20));
        if (location != null) {
          userLocation = new Position();
          userLocation = location;
        } else {
          userLocation = null;
        }
      } catch (err) {
        userLocation = null;
      }
    } else {
      userLocation = null;
    }
  }
  return userLocation;
}

Widget simpleCircularProgress() {
  return Center(
    child: CircularProgressIndicator(),
  );
}
