import 'package:flutter_task/src/data/RestData.dart';
import 'package:flutter_task/src/models/UserModel.dart';

abstract class LoginContract{
  void onLoginSuccess(UserModel user);
  void onLoginError(String error);
}

class LoginPresenter {
  LoginContract _view;
  RestData api = new RestData();
  LoginPresenter(this._view);

//Simulator login
  doLogin(String email, String password){
    api
    .login(email, password)
    .then((user) => _view.onLoginSuccess(user))
    .catchError((onError) => _view.onLoginError(onError));
  }
}