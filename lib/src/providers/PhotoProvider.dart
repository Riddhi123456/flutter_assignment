import 'package:flutter/material.dart';
import 'package:flutter_task/src/models/PhotoModel.dart';
import 'package:flutter_task/src/models/BaseModel.dart';
class PhotoProvider extends BaseModel with ChangeNotifier{
  List<PhotoModel> _list=new List();

  List<PhotoModel> get list => _list;

  void addPhotoData(List<PhotoModel> modelList){
    _list.clear();
    _list.addAll(modelList);
    notifyListeners();
  }
}