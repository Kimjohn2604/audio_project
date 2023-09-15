import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app/component/storage_key.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:http_parser/http_parser.dart';

class ApiSimulator {
  final LocalStorage storageUsername = LocalStorage(StorageKey.username);
  static Future<String> enrollApiCall(String username) async {
    Map<String, dynamic> data;
    // Tạo URL của API
    final apiUrl = Uri.http('11.11.7.18:5000', 'api/v1/enroll');
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

    final apiUrl = Uri.http('11.11.7.18:5000', 'api/v1/voice/$number');
    final response = await http.get(
      apiUrl,
      headers: <String, String>{
        'Authorization': 'ABC $getToken',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String sentence = data["data"];
      return sentence;
    } else {
      throw Exception('Failed to call API');
    }
  }

  Future<Map<String,dynamic>> postVoiceApiCall(String filePath, int number) async {
    String getToken = storageUsername.getItem(StorageKey.token);
    final postApiUrl = Uri.http('11.11.7.18:5000', 'api/v1/voice/$number');
    final request = http.MultipartRequest('POST', postApiUrl);
    request.headers.addAll({
      "Authorization": "Bearer $getToken",
      "contentType":
          'multipart/form-data;boundary=<calculated when request is sent>'
    });
    File imageFile = File(filePath);
    print("imageFile: $imageFile");
    request.files.add(await http.MultipartFile.fromPath(
        'filearg', imageFile.path,
        contentType: MediaType("audio", "wave")));
    request.fields['format'] = 'wav';
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    // Xử lý phản hồi
    if(response.statusCode != 200){
        
    }
    Map<String, dynamic> data = json.decode(response.body);
    print("received: $data");
    return data;
  }
}
