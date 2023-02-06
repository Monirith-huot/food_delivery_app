import 'package:flutter/foundation.dart';

class UUIDController extends ChangeNotifier {
  String _uuid = "";
  String get uuid => _uuid;

  void adduuid(String uuid) {
    _uuid = uuid;
    notifyListeners();
  }
}
