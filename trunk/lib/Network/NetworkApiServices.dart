import 'dart:convert';
import 'dart:io';
import 'package:Symbaa/Helper/AlertHelper.dart';
import 'package:Symbaa/Network/BaseApiServices.dart';
import 'package:Symbaa/Response/AppException.dart';
import 'package:Symbaa/Utils/AppGlobal.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import '../Helper/SharedPref.dart';

enum HeaderType { applicationJson, withoutApplicationJson }

class NetworkApiServices extends BaseApiServices {
  dynamic responseJson;

  @override
  Future getGetApiResponse(String url, {bool isExcludeToken = false}) async {
    AppGlobal.printLog('URL ==> $url');
    AppGlobal.printLog('AppGlobal.token ==> ${AppGlobal.authToken}');
    AppGlobal.printLog('AppGlobal.token ==> ${AppGlobal.authToken.isNotEmpty && !isExcludeToken}');
    final http.Response response;
    try {
      response = await http.get(Uri.parse(url), headers: (AppGlobal.authToken.isNotEmpty && !isExcludeToken) ? {'Authorization': 'bearer ${AppGlobal.authToken}', 'accept': '*/*'} : {'accept': '*/*'});

      AppGlobal.printLog('================  STATUS CODE  =======> ${response.statusCode}');
      AppGlobal.printLog('================  STATUS CODE  =======> ${AppGlobal.authToken}');
      AppGlobal.printLog('================  API RESPONSE  =====   $url  =========== \n${response.body}');

      switch (response.statusCode) {
        case 200:
          dynamic responseJson = jsonDecode(response.body);
          return responseJson;
        case 400:
          AlertHelper.showToast("${response.statusCode} Bad request!");
          break;
        case 401:
        //TODO Regenerate Token
        case 403:
          AlertHelper.showToast("${response.statusCode} Forbidden!");
          break;
        case 404:
          AlertHelper.showToast("${response.statusCode} Not found!");
          break;
        case 405:
          AlertHelper.showToast("${response.statusCode} Method not allowed!");
          break;
        case 406:
          AlertHelper.showToast("${response.statusCode} Not accepted!");
          break;
        case 409:
          AlertHelper.showToast("${response.statusCode} Conflict!");
          break;
        case 500:
          AlertHelper.showToast("${response.statusCode} Internal server error!");
          break;
        case 502:
          AlertHelper.showToast("${response.statusCode} Bad gateway!");
          break;
      }
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data, {HeaderType headerType = HeaderType.withoutApplicationJson, bool isExcludeToken = false, bool isIncludeApplicationJson = false}) async {
    AppGlobal.printLog('URL ==> $url');
    AppGlobal.printLog('AppGlobal.authToken ==> ${AppGlobal.authToken}');
    AppGlobal.printLog('Request Body ==> ${data.toString()}');
    dynamic responseJson;

    Map<String, String> header = AppGlobal.authToken.isNotEmpty && !isExcludeToken
        ? (headerType == HeaderType.applicationJson
            ? (isIncludeApplicationJson)
                ? ({'Authorization': 'bearer ${AppGlobal.authToken}', "accept": "*/*", "Content-Type": "application/json"})
                : ({'Authorization': 'bearer ${AppGlobal.authToken}', "accept": "*/*"})
            : {'Authorization': 'bearer ${AppGlobal.authToken}'})
        : (isIncludeApplicationJson)
            ? ({"accept": "*/*", "Content-Type": "application/json"})
            : {'accept': '*/*'};
    AppGlobal.printLog('Request header ==> $header');
    try {
      http.Response response = await http.post(Uri.parse(url), body: data, headers: header).timeout(const Duration(seconds: 60));

      AppGlobal.printLog('================  API RESPONSE  ================ \n${response.statusCode}');
      AppGlobal.printLog('================  API RESPONSE  =====   $url  =========== \n${response.body}');

      switch (response.statusCode) {
        case 200:
          dynamic responseJson = jsonDecode(response.body);
          return responseJson;
        case 201:
          dynamic responseJson = jsonDecode(response.body);
          return responseJson;
        case 400:
          AlertHelper.showToast("${response.statusCode} Bad request!");
          break;
        case 401:
        //TODO Regenerate Token

        case 403:
          AlertHelper.showToast("${response.statusCode} Forbidden!");
          break;
        case 404:
          AlertHelper.showToast("${response.statusCode} Not found!");
          break;
        case 405:
          AlertHelper.showToast("${response.statusCode} Method not allowed!");
          break;
        case 406:
          AlertHelper.showToast("${response.statusCode} Not accepted!");
          break;
        case 409:
          AlertHelper.showToast("${response.statusCode} Conflict!");
          break;
        case 500:
          AlertHelper.showToast("${response.statusCode} Internal server error!");
          break;
        case 502:
          AlertHelper.showToast("${response.statusCode} Bad gateway!");
          break;
      }
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponseWithImage(String url, dynamic data, File? file, fileKey) async {
    AppGlobal.printLog('URL ==> $url');
    AppGlobal.printLog('AppGlobal.token ==> ${AppGlobal.authToken}');
    AppGlobal.printLog('Request Body ==> ${data.toString()}');
    AppGlobal.printLog('Request Body file ==> ${file}');
    AppGlobal.printLog('Request Body fileKey ==> ${fileKey}');
    dynamic responseJson;

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll({'Authorization': 'bearer ${AppGlobal.authToken}'});
      request.fields.addAll(data);

      bool isExist = await file?.exists() ?? false;
      if (file != null && isExist) {
        var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
        var length = await file.length();
        var multipartFile = http.MultipartFile(fileKey, stream, length, filename: basename(file.path));
        request.files.add(multipartFile);
      }

      AppGlobal.printLog('Request Body ==> ${request.files.toString()}');

      var response = await request.send();

      AppGlobal.printLog('================  API RESPONSE  ================ \n${response.statusCode}');

      switch (response.statusCode) {
        case 200:
          dynamic responseJson = jsonDecode(await response.stream.bytesToString());
          AppGlobal.printLog('================  API RESPONSE  =====   $url  =========== \n${responseJson.toString()}');
          return responseJson;
        case 400:
          AlertHelper.showToast("${response.statusCode} Bad request!");
          break;
        case 401:
        //TODO Regenerate Token

        case 403:
          AlertHelper.showToast("${response.statusCode} Forbidden!");
          break;
        case 404:
          AlertHelper.showToast("${response.statusCode} Not found!");
          break;
        case 405:
          AlertHelper.showToast("${response.statusCode} Method not allowed!");
          break;
        case 406:
          AlertHelper.showToast("${response.statusCode} Not accepted!");
          break;
        case 409:
          AlertHelper.showToast("${response.statusCode} Conflict!");
          break;
        case 500:
          AlertHelper.showToast("${response.statusCode} Internal server error!");
          break;
        case 502:
          AlertHelper.showToast("${response.statusCode} Bad gateway!");
          break;
      }
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponseWithAudio(String url, dynamic data, File? file, fileKey) async {
    AppGlobal.printLog('URL ==> $url');
    AppGlobal.printLog('Request Body ==> ${data.toString()}');
    AppGlobal.printLog('Request Body file ==> ${file}');
    AppGlobal.printLog('Request Body fileKey ==> ${fileKey}');
    dynamic responseJson;

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll({"Content-Type": "multipart/form-data", 'accept': '*/*'});
      request.fields.addAll(data);

      bool isExist = await file?.exists() ?? false;
      if (file != null && isExist) {
        var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
        var length = await file.length();
        var multipartFile = http.MultipartFile(fileKey, stream, length, filename: basename(file.path));
        request.files.add(multipartFile);
      }

      AppGlobal.printLog('Request Body ==> ${request.files.toString()}');

      var response = await request.send();

      AppGlobal.printLog('================  API RESPONSE  ================ \n${response.statusCode}');

      switch (response.statusCode) {
        case 200:
          dynamic responseJson = jsonDecode(await response.stream.bytesToString());
          AppGlobal.printLog('================  API RESPONSE  =====   $url  =========== \n${responseJson.toString()}');
          return responseJson;
        case 400:
          AlertHelper.showToast("${response.statusCode} Bad request!");
          break;
        case 401:
        //TODO Regenerate Token

        case 403:
          AlertHelper.showToast("${response.statusCode} Forbidden!");
          break;
        case 404:
          AlertHelper.showToast("${response.statusCode} Not found!");
          break;
        case 405:
          AlertHelper.showToast("${response.statusCode} Method not allowed!");
          break;
        case 406:
          AlertHelper.showToast("${response.statusCode} Not accepted!");
          break;
        case 409:
          AlertHelper.showToast("${response.statusCode} Conflict!");
          break;
        case 500:
          AlertHelper.showToast("${response.statusCode} Internal server error!");
          break;
        case 502:
          AlertHelper.showToast("${response.statusCode} Bad gateway!");
          break;
      }
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) async {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        AlertHelper.showToast("${response.statusCode} Bad request!");
        break;
      case 401:
      //TODO Regenerate Token
      case 403:
        AlertHelper.showToast("${response.statusCode} Forbidden!");
        break;
      case 404:
        AlertHelper.showToast("${response.statusCode} Not found!");
        break;
      case 405:
        AlertHelper.showToast("${response.statusCode} Method not allowed!");
        break;
      case 406:
        AlertHelper.showToast("${response.statusCode} Not accepted!");
        break;
      case 409:
        AlertHelper.showToast("${response.statusCode} Conflict!");
        break;
      case 500:
        AlertHelper.showToast("${response.statusCode} Internal server error!");
        break;
      case 502:
        AlertHelper.showToast("${response.statusCode} Bad gateway!");
        break;
    }
  }
}
