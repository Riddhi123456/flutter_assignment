import 'package:flutter/material.dart';
import 'package:flutter_task/src/base/BaseState.dart';
import 'package:flutter_task/src/intent/IntentHelper.dart';
import 'package:flutter_task/src/models/UserModel.dart';
import 'package:flutter_task/src/resources/CommonColor.dart';
import 'package:flutter_task/src/resources/Dimen.dart';
import 'package:flutter_task/src/resources/Strings.dart';
import 'package:flutter_task/src/data/Presenter.dart';
import 'package:flutter_task/src/widget/BigButtonView.dart';
import 'package:flutter_task/src/widget/EditTextWithBorder.dart';
import 'package:flutter_task/src/widget/TextView.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginScreenState();
  }
}

class LoginScreenState extends BaseState<LoginScreen> implements LoginContract {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  FocusNode _emailFocus = new FocusNode();
  FocusNode _passwordFocus = new FocusNode();

  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();

  LoginPresenter _presenter;

  LoginScreenState() {
    _presenter = new LoginPresenter(this);
  }

  @override
  Widget getBuildWidget(BuildContext context) {
    // TODO: implement getBuildWidget
    return Container(
      color: CommonColor.white,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
                title: Strings.login,
                fontColor: CommonColor.primaryDark,
                fontSize: Dimen.txtSize20px,
                textAlign: TextAlign.center,
                alignment: Alignment.center,
                fontWeight: FontWeight.bold,
                margin: EdgeInsets.only(bottom: 15)),
            EditTextBorder(
              margin: EdgeInsets.only(top: 8, right: 10, left: 10),
              controller: _emailController,
              focus: _emailFocus,
              hint: Strings.email,
              bgColor: CommonColor.white,
            ),
            EditTextBorder(
                margin: EdgeInsets.only(top: 8, right: 10, left: 10),
                controller: _passwordController,
                focus: _passwordFocus,
                hint: Strings.password,
                obscureText: true,
                bgColor: CommonColor.white),
            bigButtonView(
                margin: EdgeInsets.only(right: 10, left: 10, top: 20),
                label: Strings.login,
                isEnabled: true,
                enableColor: CommonColor.red,
                onClick: _submit,
                padding: EdgeInsets.only(left: 20, right: 20)),
            InkWell(
              onTap: () {
                signUpScreenIntent(context);
              },
              child: TextView(
                  title: Strings.create_new_account,
                  fontColor: CommonColor.primaryDark,
                  fontSize: Dimen.txtSize16px,
                  textAlign: TextAlign.left,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(bottom: 15, top: 15, left: 15)),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_emailController.text, _passwordController.text);
      });
    }
  }

  @override
  AppBar getToolBar(BuildContext context) {
    // TODO: implement getToolBar
    return null;
  }

  @override
  void onScreenReady(BuildContext context) {
    // TODO: implement onScreenReady
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    showSnackBar("Login not successful");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(UserModel user) async {
    // TODO: implement onLoginSuccess
    if (user.email == "") {
      showSnackBar("Login not successful");
    }
    setState(() {
      _isLoading = false;
    });
    if (user.flaglogged == "logged") {
      print("Logged");
      homeScreenIntent(context,email: _emailController.text);
    } else {
      print("Not Logged");
      showSnackBar("Login not successful");
    }
  }
}
