import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiSimulator {
  Future<bool> simulateApiCall(String username) async {
    // Tạo URL của API
    final apiUrl = Uri.parse(
        'http://10.250.194.245:8080/api/v1/enroll'); // Thay YOUR_API_URL_HERE bằng URL của API thật sự

    final requestData = {
      "username": username,
    };

    // Gửi yêu cầu API
    final response = await http.post(
      apiUrl,
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return true;
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      return false;
    }
  }
}
