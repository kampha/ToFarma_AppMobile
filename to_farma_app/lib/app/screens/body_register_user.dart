import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:to_farma_app/app/screens/body_form_register_user.dart';
import 'package:to_farma_app/app/widgets/widgets.dart';
import 'package:to_farma_app/core/providers/providers.dart';
import 'package:to_farma_app/core/utlis/utlis.dart';

import 'package:badges/badges.dart' as badges;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class BodyRegisterUser extends StatefulWidget {
  const BodyRegisterUser({super.key});

  @override
  State<BodyRegisterUser> createState() => _BodyRegisterUserState();
}

class _BodyRegisterUserState extends State<BodyRegisterUser> {
  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;

    final configProvider = Provider.of<ConfigurationProvider>(context);
    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 14,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                badges.Badge(
                  position: badges.BadgePosition.topEnd(
                    top: 102,
                    end: 1.5,
                  ),
                  badgeContent: const Icon(Icons.edit, color: Colors.black),
                  child: Container(
                    //color: Colors.green,
                    height: 135,
                    width: 135,
                    child: CircleAvatar(
                      radius: currentSize.width * 0.18,
                      backgroundImage: (configProvider.imageCropPhofile != null)
                          ? FileImage(
                                  File(configProvider.imageCropPhofile!.path))
                              as ImageProvider<Object>
                          : const AssetImage(Assets.avatarProfile),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialogPhoto(context: context);
                  },
                  child: Container(
                    height: 135, //medidas del diseño
                    width: 135,
                    color: Colors.white.withOpacity(0.0),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, 10),
              child: const SingleChildScrollView(
                child: BodyFormRegisterUser(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ////permisos a camara y galeria
  _getFromCamera() async {
    try {
      final ImagePicker picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        //reducir el tamaño de la imagen
        _loadCropImage(pickedFile);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _getFromGallery() async {
    try {
      XFile? pickedFile = XFile(Assets.avatarProfile);

      final ImagePicker picker = ImagePicker();
      pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        //reducir el tamaño de la imagen
        _loadCropImage(pickedFile);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> showDialogPhoto({
    required BuildContext context,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: const Center(child: Text('Cargar foto')),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ///camara
                ButtonActionWidget(
                  function: () async {
                    FocusScope.of(context).unfocus();
                    final permissionsProvider =
                        Provider.of<PermissionsProvider>(context,
                            listen: false);

                    await permissionsProvider.initPermissions();

                    await permissionsProvider
                        .requestPermissionCamera()
                        .then((value) {
                      if (permissionsProvider.cameraPermissionStatus ==
                          PermissionStatus.granted) {
                        _getFromCamera();
                        Navigator.pop(context);
                      } else {
                        //mostrar una alerta dialog
                        print(
                            "permisos status denegados: ${permissionsProvider.galleryPermissionStatus}");
                      }
                    });
                  },
                  titleButton: 'Camára',
                ),

                ///espacio
                const SizedBox(
                  height: 20,
                ),

                ///galeria
                ButtonActionWidget(
                  function: () async {
                    FocusScope.of(context).unfocus();
                    final permissionsProvider =
                        Provider.of<PermissionsProvider>(context,
                            listen: false);

                    await permissionsProvider.initPermissions();

                    await permissionsProvider
                        .requestPermissionPhotos()
                        .then((value) {
                      if (permissionsProvider.galleryPermissionStatus ==
                          PermissionStatus.granted) {
                        _getFromGallery();
                        Navigator.pop(context);
                      } else {
                        //mostrar una alerta dialog
                        print(
                            "permisos status denegados: ${permissionsProvider.galleryPermissionStatus}");
                      }
                    });
                  },
                  titleButton: 'Galería',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    fontFamily: 'Montserrat,SemiBold',
                    color: CustomColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.040,
                    // Aquí puedes ajustar el tamaño del texto en función del ancho de la pantalla.
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  ////recortar la imagen
  void _loadCropImage(XFile? pickedFile) async {
    final configProvider =
        Provider.of<ConfigurationProvider>(context, listen: false);

    final Directory directory = await getTemporaryDirectory();

    final File? compressedFile = await FlutterImageCompress.compressAndGetFile(
      pickedFile!.path,
      "${directory.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg",
      quality: 10, // Elige un valor de calidad entre 0 y 100
    );

    configProvider.imageFile =
        compressedFile != null ? File(compressedFile.path) : null;

    final bytes = await configProvider.imageFile!.readAsBytes().then(
      (value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageCropperWidget(imageBytes: value),
          ),
        );
      },
    );
  }
}
