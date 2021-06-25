import 'dart:convert';

import 'package:flutter_task/src/mappers/AbstractMapper.dart';
import 'package:flutter_task/src/models/PhotoModel.dart';
import 'package:flutter_task/src/providers/PhotoProvider.dart';
import 'package:flutter_task/src/resources/Strings.dart';
import 'package:flutter_task/src/utils/Utils.dart';

class PhotoMapper extends AbstractMapper<String,PhotoProvider>{
  @override
  PhotoProvider toViewModel(String jsonString, int statusCode) {
    // TODO: implement toViewModel
    PhotoProvider model=new PhotoProvider();
    if (statusCode == 200){
      List<dynamic> jsonMap = json.decode(jsonString);
      model.status=true;
      List ss=jsonMap as List;
      if(ss!=null && ss.length>0){
        for(int i=0;i<ss.length;i++){
          Map data=ss.elementAt(i);
          if(data!=null){
            PhotoModel photoModel=new PhotoModel();
            photoModel.authorName=getFieldValue(data,'author');
            photoModel.url=getFieldValue(data, 'download_url');
            model.list.add(photoModel);
          }else {
            model.status = false;
            model.error = Strings.try_again;
          }
        }
      }else {
        print('noo data in list');
      }
    }else if (statusCode == 500) {
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      if (jsonMap.containsKey('code') &&
          jsonMap['code'] != null &&
          jsonMap['code'].toString() == '10') {
        model.status = true;
      } else {
        model.status = false;
        model.error = errorMessage(statusCode);
      }
    } else {
      model.status = false;
      model.error = errorMessage(statusCode);
    }
    return model;
  }

}