class UserModel {
  String name;
  String email;
  String password;
  String number;
  String image;
  String flaglogged;

  UserModel({this.name, this.email, this.password,this.number,this.image ,this.flaglogged});

  UserModel.map(dynamic obj) {
    this.name = obj['name'];
    this.email = obj['email'];
    this.password = obj['password'];
    this.number = obj['number'];
    this.image = obj['image'];
    this.flaglogged = obj['floglogged'];
  }



  /*String get name => _name;
  String get email => _email;
  String get password => _password;
  String get number => _number;
  String get image => _image;
  String get flaglogged => _flaglogged;*/

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["email"] = email;
    map["password"] = password;
    map["number"] = number;
    map["image"] = image;
    map["flaglogged"] = flaglogged;
    return map;
  }

}
