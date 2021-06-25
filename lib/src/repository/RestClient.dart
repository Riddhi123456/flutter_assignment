import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_task/src/api/ApiType.dart';
import 'package:flutter_task/src/api/BaseApis.dart';
import 'package:flutter_task/src/mappers/AbstractMapper.dart';
import 'package:flutter_task/src/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RestClient {
  Future<T> apiRequest<T>({ApiType apiType,
    String endPoint,
    Map map,
    AbstractMapper<String, T> mapper,
    String query,
    String jsonObject,
    bool isRawData = false,
    Map header}) async {
    Uri uri;
    http.Response response;
    if (apiType == ApiType.GET) {
      uri = new Uri.https(BaseApis.PHOTO, endPoint, map);
      if (query != null && query.isNotEmpty) {
        uri = uri.replace(query: query);
      }

      response = await http.get(Uri.parse(uri.toString()), headers: header);
    } else if (apiType == ApiType.POST) {
      uri = new Uri.https(BaseApis.PHOTO, endPoint);
      if (query != null && query.isNotEmpty) {
        uri = uri.replace(query: query);
      }

      response = await http.post(Uri.encodeFull(uri.toString()),
          body: isRawData ? jsonObject : map, headers: header);
    }
    int code = response.statusCode;

    printLog("Status Code :- ${response.statusCode}");
    if (code == 500) {
      code = 200;
    }

    return mapper.toViewModel(response.body, code);
  }

}
