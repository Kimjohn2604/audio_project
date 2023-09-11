import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiSimulator {
  Future<bool> simulateApiCall() async {
    // Giả lập việc gọi API sau 2 giây
    await Future.delayed(const Duration(seconds: 2));

    // var url = "";
    // var filename = "/sdcard/Download/audio_3289.wav";

    // var request = http.MultipartRequest('POST', Uri.parse(url));
    
    // request.files.add(http.MultipartFile('records',
    //     File(filename).readAsBytes().asStream(), File(filename).lengthSync(),
    //     filename: filename.split("/").last));

    // var response = await request.send();

    // if (kDebugMode) {
    //   print('Response status: ${response.statusCode}');
    // }
    // Trả về kết quả true hoặc false dựa trên một điều kiện tùy ý
    return false;
  }
}
