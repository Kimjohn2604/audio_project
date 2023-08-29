import 'dart:async';
class ApiSimulator {
  Future<bool> simulateApiCall() async {
    // Giả lập việc gọi API sau 2 giây
    await Future.delayed(const Duration(seconds: 2));

    // Trả về kết quả true hoặc false dựa trên một điều kiện tùy ý
    return true;
  }
}