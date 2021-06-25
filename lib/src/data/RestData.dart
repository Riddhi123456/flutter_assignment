import 'dart:async';

import 'package:flutter_task/src/data/DatabaseHelper.dart';
import 'package:flutter_task/src/models/UserModel.dart';

class RestData {
  Future<UserModel> login(String email, String password) async {
    String logged = "logged";
    //simulate internet connection by selecting the local database to check if user has already been registered
    var user = new UserModel(email: email, password: password);
    var db = new DatabaseHelper();
    var userRetorno = new UserModel();
    userRetorno = await db.selectUser(user);
    if (userRetorno != null) {
      logged = "logged";
      return new Future.value(new UserModel(email: email, password: password, flaglogged: logged));
    } else {
      logged = "not";
      return new Future.value(new UserModel(email: email, password: password, flaglogged: logged));
    }
  }
}
