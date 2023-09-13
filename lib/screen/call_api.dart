import 'dart:async';
import 'dart:convert';
import 'package:app/component/storage_key.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class ApiSimulator {
  final LocalStorage storageUsername = LocalStorage(StorageKey.username);
  static Future<String> enrollApiCall(String username) async {
    Map<String, dynamic> data;
    // Tạo URL của API
    final apiUrl = Uri.http('10.250.194.245:8080', 'api/v1/enroll');
    final requestData = {
      "username": username,
    };
    
    // Gửi yêu cầu API
    final response = await http.post(
      apiUrl,
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      String token = data["data"]["token"];
      print("token:$token");
      return token;
    } else {
      return "";
    }
  }

  Future<String> voiceApiCall(int number) async {
    String getToken = storageUsername.getItem(StorageKey.token);
         
    print("storage: $getToken");
    final apiUrl = Uri.http('10.250.194.245:8080', 'api/v1/voice/$number');
    final response = await http.get(
      apiUrl,
      headers: <String, String>{
        'Authorization': 'ABC $getToken',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String sentence = data["data"];
      print("data: $sentence");
      return sentence;
    } else {
      throw Exception('Failed to call API');
    }
  }
}
