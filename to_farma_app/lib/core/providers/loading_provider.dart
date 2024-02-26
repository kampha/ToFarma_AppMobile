import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoadingProviders extends ChangeNotifier {
  ValueNotifier<bool> cisLoading = ValueNotifier(false);

  bool get isLoading => cisLoading.value;

  set isLoading(bool value) {
    cisLoading.value = value;
    notifyListeners();
  }
}
