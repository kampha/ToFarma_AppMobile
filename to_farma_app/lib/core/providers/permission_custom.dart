import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:to_farma_app/core/utlis/utlis.dart';

//solictar permisos de camara y galeria en ios / android
///**
/// implementacion:
///  final permissionsProvider =  Provider.of<PermissionsProvider>(context, listen: false);
///  await permissionsProvider.initPermissions();
///  await permissionsProvider.requestPermissionPhotos().
///
///
///
class PermissionsProvider with ChangeNotifier {
  PermissionStatus? _cameraPermissionStatus = PermissionStatus.denied;
  PermissionStatus? _galleryPermissionStatus = PermissionStatus.denied;

  PermissionsProvider() {
    initPermissions();
  }

  PermissionStatus get cameraPermissionStatus => _cameraPermissionStatus!;
  PermissionStatus get galleryPermissionStatus => _galleryPermissionStatus!;

  //iniciliazar los permoisos
  Future<void> initPermissions() async {
    final String? getPlatform = await GetDeviceInformation.getPlatformName();
    (getPlatform!.contains('IOS'))
        ? _galleryPermissionStatus = await Permission.photos.status
        : _galleryPermissionStatus = await Permission.storage.status;
    //ambos plataformas
    _cameraPermissionStatus = await Permission.camera.status;
    notifyListeners();
  }

  Future<void> requestPermissionCamera() async {
    if (_cameraPermissionStatus != PermissionStatus.granted) {
      final status = await Permission.camera.request();
      _cameraPermissionStatus = status;
      notifyListeners();
    }
  }

  Future<void> requestPermissionPhotos() async {
    if (_galleryPermissionStatus != PermissionStatus.granted) {
      PermissionStatus status;

      final String? getPlatform = await GetDeviceInformation.getPlatformName();
      (getPlatform!.contains('IOS'))
          ? status = await Permission.photos.request()
          : status = await Permission.storage.request();

      _galleryPermissionStatus = status;
      notifyListeners();
    }
  }
}
