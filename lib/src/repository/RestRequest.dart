import 'package:flutter/material.dart';
import 'package:flutter_task/src/api/ApiType.dart';
import 'package:flutter_task/src/api/ApiUtil.dart';
import 'package:flutter_task/src/listener/BaseResponceListener.dart';
import 'package:flutter_task/src/mappers/AbstractMapper.dart';
import 'package:flutter_task/src/mappers/PhotoMapper.dart';
import 'package:flutter_task/src/repository/RestClient.dart';
import 'package:flutter_task/src/resources/Strings.dart';
import 'package:flutter_task/src/utils/Utils.dart';
import 'package:http/http.dart' as http;

class RestRequest<T> {
  BuildContext context;
  RestRequest({this.context});

  photoListApi(
      BaseResponseListener<T> listener
      ){
    _hitPhotoApi(
      type: ApiType.GET,
      endPoint: PHOTO_API,
      listener: listener,
      mapper: PhotoMapper()
    );
  }

  _hitPhotoApi(
      {ApiType type,
      Map values,
      String endPoint,
      Map header,
      BaseResponseListener<T> listener,
      AbstractMapper mapper,
      String query,
      String jsonObject,
      bool isRawData = false}) async {
    listener.showProgress(true);
    isConnected().then(
      (b) {
        if (b != null && b) {
          RestClient()
              .apiRequest(
                  apiType: type,
                  endPoint: endPoint,
                  map: values,
                  jsonObject: jsonObject,
                  mapper: mapper,
                  query: query,
                  header: header,
                  isRawData: isRawData)
              .then((dataModel) {
            if (dataModel != null) {
              if (dataModel.status) {
                listener.showProgress(false);
                listener.updateIfLive(dataModel);
              } else {
                listener.showProgress(false);
                listener.onError(dataModel.error);
              }
            } else {
              listener.showProgress(false);
              listener.onError('null data model');
            }
          }, onError: (ee) {
            printLog(ee.toString());
            listener.showProgress(false);
            listener.onError(Strings.try_again);
          });
        } else {
          listener.showProgress(false);
          listener.onError(Strings.no_internet);
        }
      },
      onError: (ee) {
        listener.showProgress(false);
        listener.onError(Strings.internet_error);
      },
    );
  }


}
