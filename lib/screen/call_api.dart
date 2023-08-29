import 'dart:async';

import 'package:app/component/storage_key.dart';
import 'package:localstorage/localstorage.dart';

class ApiSimulator {
  final LocalStorage storage = LocalStorage(StorageKey.sentence);

  Future<bool> simulateApiCall() async {
    // Giả lập việc gọi API sau 2 giây
    await Future.delayed(const Duration(seconds: 2));
    int currentNumber = storage.getItem(StorageKey.sentence);
    if(currentNumber == 3){
      
    }
    storage.setItem(StorageKey.sentence, currentNumber + 1);
    // Trả về kết quả true hoặc false dựa trên một điều kiện tùy ý
    return true;
  }
}
