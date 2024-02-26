import 'dart:io';

import 'package:flutter/material.dart';

class ConfigurationProvider extends ChangeNotifier {
  bool _isCheckDarkMode = false;
  bool _isCheckAutomaticMode = false;
  bool _isPhotoProfile = false;

  //imageFile
  File? _imageFile;
  File? _imageCropPhofile;

  bool get isCheckDarkMode => _isCheckDarkMode;
  bool get isCheckAutomaticMode => _isCheckAutomaticMode;
  bool get isPhotoProfile => _isPhotoProfile;
  File? get imageFile => _imageFile;
  //imagen recortada
  File? get imageCropPhofile => _imageCropPhofile;

  BuildContext? _context;

  BuildContext? get getContext => _context;

  set setContext(BuildContext? context) {
    _context = context;
    notifyListeners();
  }

  set imageFile(File? file) {
    _imageFile = file;
    notifyListeners();
  }

  set imageCropPhofile(File? file) {
    _imageCropPhofile = file;
    notifyListeners();
  }

  set isCheckDarkMode(bool value) {
    _isCheckDarkMode = value;
    notifyListeners();
  }

  set isCheckAutomaticMode(bool value) {
    _isCheckAutomaticMode = value;
    notifyListeners();
  }

  set isPhotoProfile(bool value) {
    _isPhotoProfile = value;
    notifyListeners();
  }
}
