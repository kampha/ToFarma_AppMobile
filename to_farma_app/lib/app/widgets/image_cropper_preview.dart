import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:to_farma_app/core/providers/providers.dart';
import 'package:to_farma_app/core/utlis/utlis.dart';

class ImageCropperWidget extends StatefulWidget {
  final Uint8List imageBytes;

  const ImageCropperWidget({super.key, required this.imageBytes});

  @override
  _ImageCropperWidgetState createState() => _ImageCropperWidgetState();
}

class _ImageCropperWidgetState extends State<ImageCropperWidget> {
  late final CropController _cropController;

  @override
  void initState() {
    super.initState();
    _cropController = CropController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;
    final configProvider = Provider.of<ConfigurationProvider>(context);
    return Scaffold(
      body: Container(
        color: CustomColors.ButtonEnabledAction,
        child: Column(
          children: [
            SizedBox(
              height: currentSize.height * 0.08,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                alignment: AlignmentDirectional.centerStart,
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: currentSize.height * 0.02),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Text(
                    'Ajustar Foto de perfil',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat,SemiBold',
                      color: CustomColors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.038,
                      // Aquí puedes ajustar el tamaño del texto en función del ancho de la pantalla.
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: currentSize.height * 0.10),
              child: Container(
                height: currentSize.height * 0.50,
                color: Colors.black,
                child: Crop(
                  controller: _cropController,
                  image: widget.imageBytes,
                  onCropped: (image) async {
                    // Escribir los datos de la imagen en el archivo

                    String imageName = path.basenameWithoutExtension(
                        configProvider.imageFile!.path);
                    File file = await File(
                            '${(await getTemporaryDirectory()).path}/$imageName${DateTime.now()}.jpg')
                        .create();
                    configProvider.imageCropPhofile =
                        await file.writeAsBytes(image);
                  },
                  aspectRatio: 4 / 3,
                  withCircleUi: true,
                  radius: 150, // Ajustar el radio a la medida deseada
                  // initialSize: 0.5,
                  // initialArea: Rect.fromLTWH(240, 212, 800, 600),
                  initialAreaBuilder: (rect) => Rect.fromLTRB(rect.left + 20,
                      rect.top + 20, rect.right - 20, rect.bottom - 20),
                  // withCircleUi: true,
                  baseColor: Colors.black,
                  maskColor: Colors.white.withOpacity(0.50),
                  onMoved: (newRect) {
                    // do something with current cropping area.
                  },
                  onStatusChanged: (status) {
                    // do something with current CropStatus
                  },
                  cornerDotBuilder: (size, edgeAlignment) =>
                      DotControl(color: Colors.blue.withOpacity(0)),
                  interactive: true,
                  fixArea: false,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: currentSize.height * 0.15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(),
                  button(
                    context: context,
                    function: () => Navigator.of(context).pop(),
                    style: Theme.of(context).outlinedButtonTheme.style!,
                    text: 'Cancelar',
                    buttonWidth: 145,
                    buttonHeight: 45,
                  ),
                  button(
                    context: context,
                    function: () async {
                      _getImageCrop();
                    },
                    style: Theme.of(context).elevatedButtonTheme.style!,
                    text: 'Aceptar',
                    buttonWidth: 145,
                    buttonHeight: 45,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget button({
    required BuildContext context,
    required Function() function,
    required ButtonStyle style,
    required String text,
    required double buttonWidth,
    required double buttonHeight,
  }) {
    return Container(
      margin: const EdgeInsets.all(Dimens.alertScreenButtonMargin),
      width: buttonWidth,
      height: buttonHeight,
      child: TextButton(
          style: style,
          onPressed: () {
            function();
          },
          child: Text(text, style: const TextStyle(color: Colors.white))),
    );
  }

  void _getImageCrop() async {
    /*final configProvider =
        Provider.of<ConfigurationProvider>(context, listen: false);
    _cropController.crop();*/

    Navigator.pop(context);
  }
}
