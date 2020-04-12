import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../utils/Constant.dart';

class APICall {
  static final APICall _apiCall = APICall._internal();

  factory APICall() {
    return _apiCall;
  }

  static Future<Map> getJsonData(String parameters) async {
    var responceJson;

    final encoding = Encoding.getByName('utf-8');
    final String uri = Constant.baseURL + parameters;
    final headers = {'Content-Type': 'application/json'};

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var jsonObj = jsonDecode(response.body);
      return jsonObj;
    } else {
      responceJson = {
        "code": response.statusCode,
        "message": 'Unable to Reach Server',
        "responce": Null,
      };
      return responceJson;
    }
  }

  static Future<Map> getJsonModelData(String parameters) async {
    var responceJson;
    final headers = {'Content-Type': 'application/json'};

    var response = await http.get(parameters, headers: headers);
    if (response.statusCode == 200) {
      var jsonObj = jsonDecode(response.body);
      return jsonObj;
    } else {
      responceJson = {
        "code": response.statusCode,
        "message": 'Unable to Reach Server',
        "responce": Null,
      };
      return responceJson;
    }
  }

  static Future<Map> postJsonData(
      String parameters, Map<String, String> Json) async {
    print("$parameters, $Json");
    var responceJson;
    final String uri = Constant.baseURL + parameters;
    final String jsonBody = json.encode(Json);
    final encoding = Encoding.getByName('utf-8');
    final headers = {'Content-Type': 'application/json'};

    var response = await http.post(uri,
        headers: headers, body: jsonBody, encoding: encoding);
  print(" reponse123   $response.statusCode");
    if (response.statusCode == 200) {
    
      var jsonResponce = json.decode(response.body);
      return jsonResponce;
      
    } else {
      responceJson = {
        "code": response.statusCode,
        "message": 'Unable to Reach Server',
        "responce": Null,
      };
      return responceJson;
    }
  }

  static Future<Map> postJsonApi(
      String parameters, Map<String, String> Json) async {
    print("$parameters, $Json");
    var responceJson;
    final String uri = Constant.baseURL1 + parameters;
    final String jsonBody = json.encode(Json);
    final encoding = Encoding.getByName('utf-8');
    final headers = {'Content-Type': 'application/json'};

    var response = await http.post(uri,
        headers: headers, body: jsonBody, encoding: encoding);

    if (response.statusCode == 200) {
      var jsonResponce = json.decode(response.body);
      return jsonResponce;
    } else {
      responceJson = {
        "code": response.statusCode,
        "message": 'Unable to Reach Server',
        "responce": Null,
      };
      return responceJson;
    }
  }

  static Future<Map> postJsonData1(
      String parameters, Map<String, Object> Json) async {
    var responceJson;
    final String uri = Constant.baseURL + parameters;
    final String jsonBody = json.encode(Json);
    print("jsonbody.." + jsonBody);
    final encoding = Encoding.getByName('utf-8');
    final headers = {'Content-Type': 'application/json'};
    var response = await http.post(uri,
        headers: headers, body: jsonBody, encoding: encoding);
    if (response.statusCode == 200) {
      var jsonResponce = json.decode(response.body);
      print("jsonResponce..... $jsonResponce");
      return jsonResponce;
    } else {
      responceJson = {
        "code": response.statusCode,
        "message": 'Unable to Reach Server',
        "responce": Null,
      };
      print(responceJson);
      return responceJson;
    }
  }

  static Future<Map> postJsonData2(
      String parameters, Map<String, Object> Json) async {
    var responceJson;
    final String uri = Constant.baseURL2 + parameters;
    print("url $uri");
    final String jsonBody = json.encode(Json);
    print("jsonbody.." + jsonBody);
    final encoding = Encoding.getByName('utf-8');
    final headers = {'Content-Type': 'application/json'};
    var response = await http.post(uri,
        headers: headers, body: jsonBody, encoding: encoding);
    if (response.statusCode == 200) {
      var jsonResponce = json.decode(response.body);
      print("jsonResponce..... $jsonResponce");
      return jsonResponce;
    } else {
      responceJson = {
        "code": response.statusCode,
        "message": 'Unable to Reach Server',
        "responce": Null,
      };
      print(responceJson);
      return responceJson;
    }
  }

  APICall._internal();
}
