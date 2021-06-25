import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_task/src/base/BaseState.dart';
import 'package:flutter_task/src/data/DatabaseHelper.dart';
import 'package:flutter_task/src/intent/IntentHelper.dart';
import 'package:flutter_task/src/models/UserModel.dart';
import 'package:flutter_task/src/resources/CommonColor.dart';
import 'package:flutter_task/src/resources/Dimen.dart';
import 'package:flutter_task/src/resources/Strings.dart';
import 'package:flutter_task/src/utils/Utils.dart';
import 'package:flutter_task/src/widget/BigButtonView.dart';
import 'package:flutter_task/src/widget/EditTextWithBorder.dart';
import 'package:flutter_task/src/widget/ImageViewAssets.dart';
import 'package:flutter_task/src/widget/PickImageBottomSheet.dart';
import 'package:flutter_task/src/widget/TextView.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignUpScreenState();
  }
}

class SignUpScreenState extends BaseState<SignUpScreen> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _numberController = new TextEditingController();
  FocusNode _emailFocus = new FocusNode();
  FocusNode _passwordFocus = new FocusNode();
  FocusNode _nameFocus = new FocusNode();
  FocusNode _numberFocus = new FocusNode();

  File imageCard;
  String imageText = '';

  final formKey = new GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget getBuildWidget(BuildContext context) {
    // TODO: implement getBuildWidget
    return Container(
      color: CommonColor.white,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextView(
                title: Strings.signupForm,
                fontColor: CommonColor.primaryDark,
                fontSize: Dimen.txtSize20px,
                textAlign: TextAlign.center,
                alignment: Alignment.center,
                fontWeight: FontWeight.bold,
                margin: EdgeInsets.only(bottom: 15)),
            InkWell(
              onTap: () {
                pickImageFromDeviceBottomSheet(context, filename: "Image1").then((value) {
                  if (value != null && value.path.isNotEmpty) {
                    if (checkFileExtension(value.path)) {
                      setState(() {
                        imageCard = value;
                        imageText = value.path;
                      });
                    }
                  }
                });
              },
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: ClipOval(
                      clipBehavior: Clip.antiAlias,
                      child: imageText.length > 0
                          ? Image.file(
                              imageCard,
                              height: 65,
                              width: 65,
                              fit: BoxFit.cover,
                            )
                          : imageViewAsset(
                              imagePath: 'assets/images/profile_dummy.jpg',
                              imageWidth: 65,
                              imageHeight: 65,
                              fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 38, left: 40),
                      child: Icon(
                        Icons.edit,
                        color: CommonColor.primaryDark,
                        size: 25,
                      )),
                ],
              ),
            ),
            EditTextBorder(
              margin: EdgeInsets.only(top: 8, right: 10, left: 10),
              controller: _nameController,
              focus: _nameFocus,
              hint: Strings.name,
              bgColor: CommonColor.white,
            ),
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
            EditTextBorder(
              margin: EdgeInsets.only(top: 8, right: 10, left: 10),
              controller: _numberController,
              focus: _numberFocus,
              hint: Strings.number,
              inputType: TextInputType.phone,
              maxlength: 10,
              onChanged: (text) {
                if (text.length == 10) FocusScope.of(context).requestFocus(new FocusNode());
              },
              bgColor: CommonColor.white,
            ),
            bigButtonView(
                margin: EdgeInsets.only(right: 10, left: 10, top: 20),
                label: Strings.signup,
                isEnabled: isEnable(),
                onClick: _submit,
                enableColor: CommonColor.red,
                padding: EdgeInsets.only(left: 20, right: 20)),
          ],
        ),
      ),
    );
  }

  bool isEnable() {
    bool enable = false;
    if (_nameController.text != null &&
        _nameController.text.isNotEmpty &&
        _emailController.text != null &&
        _emailController.text.isNotEmpty &&
        _passwordController.text != null &&
        _passwordController.text.isNotEmpty &&
        _numberController.text != null &&
        _numberController.text.isNotEmpty) {
      enable = true;
    }
    return enable;
  }

  void _submit() {
    final form = formKey.currentState;
    if (isPhoneNumberValidator(_numberController.text)) {
      if (form.validate()) {
        setState(() {
          _isLoading = true;
          form.save();
          var user = new UserModel(name: _nameController.text,email: _emailController.text,
              password: _passwordController.text,number: _numberController.text,image: imageText,
              flaglogged: null);
          var db = new DatabaseHelper();
          db.saveUser(user);
          _isLoading = false;
          loginScreenIntent(context);
        });
      }
    } else {
      showSnackBar(Strings.valid_phone_number);
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
}
