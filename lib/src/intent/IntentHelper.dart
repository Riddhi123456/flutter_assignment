import 'package:flutter/material.dart';
import 'package:flutter_task/src/ui/HomeScreen.dart';
import 'package:flutter_task/src/ui/LoginScreen.dart';
import 'package:flutter_task/src/ui/SignUpScreen.dart';

homeScreenIntent(BuildContext context,{String email}) async {
  var route = new MaterialPageRoute(
    builder: (BuildContext context) {
      return new HomeScreen(email: email);
    },
  );
  Navigator.of(context).pushReplacement(route);
}

signUpScreenIntent(BuildContext context) async {
  var route = new MaterialPageRoute(
    builder: (BuildContext context) {
      return new SignUpScreen();
    },
  );
  Navigator.of(context).pushReplacement(route);
}

loginScreenIntent(BuildContext context) async {
  var route = new MaterialPageRoute(
    builder: (BuildContext context) {
      return new LoginScreen();
    },
  );
  Navigator.of(context).pushReplacement(route);
}
