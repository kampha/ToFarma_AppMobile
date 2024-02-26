import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_farma_app/app/pages/information_user_page.dart';
import 'package:to_farma_app/core/providers/providers.dart';
import 'package:to_farma_app/core/utlis/assets.dart';
import 'package:to_farma_app/core/utlis/custom_colors.dart';

class AppbarLogin extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;

  final Widget? iconCenter;
  final Function? iconCenterEvent;
  final bool? showiconCenter;
  final Color? coloriconCenter;
  final double? sizeiconCenter;

  final Widget? rightIcon;
  final Function? rightIconEvent;
  final bool? showRightIcon;
  final Color? colorRightIcon;
  final double? sizeRightIcon;

  final Widget? leftIcon;
  final Function? leftIconEvent;
  final bool? showLeftIcon;
  final Color? colorLeftIcon;
  final double? sizeLeftIcon;

  const AppbarLogin({
    super.key,
    required this.height,
    required this.title,
    this.iconCenter,
    this.iconCenterEvent,
    this.showiconCenter,
    this.coloriconCenter,
    this.sizeiconCenter,
    this.rightIcon,
    this.rightIconEvent,
    this.showRightIcon,
    this.colorRightIcon,
    this.sizeRightIcon,
    this.leftIcon,
    this.leftIconEvent,
    this.showLeftIcon,
    this.colorLeftIcon,
    this.sizeLeftIcon,
  });

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      //color: Colors.amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (showiconCenter == true)
            Transform.translate(
                offset: const Offset(0, 27),
                child: Container(
                  child: iconCenter,
                )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showLeftIcon == true)
                  Container(
                    child: leftIcon,
                  ),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Montserrat,SemiBold',
                    color: CustomColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.060,
                    // Aquí puedes ajustar el tamaño del texto en función del ancho de la pantalla.
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

////appbar del menu principal
class CustomAppBarMenu extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;

  final bool menudisplay;

  final Widget? iconCenter;
  final Function? iconCenterEvent;
  final bool? showiconCenter;
  final Color? coloriconCenter;
  final double? sizeiconCenter;

  final Widget? rightIcon;
  final Function? rightIconEvent;
  final bool? showRightIcon;
  final Color? colorRightIcon;
  final double? sizeRightIcon;

  final Widget? leftIcon;
  final Function? leftIconEvent;
  final bool? showLeftIcon;
  final Color? colorLeftIcon;
  final double? sizeLeftIcon;

  const CustomAppBarMenu({
    super.key,
    required this.height,
    required this.title,
    this.iconCenter,
    this.iconCenterEvent,
    this.showiconCenter,
    this.coloriconCenter,
    this.sizeiconCenter,
    this.rightIcon,
    this.rightIconEvent,
    this.showRightIcon,
    this.colorRightIcon,
    this.sizeRightIcon,
    this.leftIcon,
    this.leftIconEvent,
    this.showLeftIcon,
    this.colorLeftIcon,
    this.sizeLeftIcon,
    required this.menudisplay,
  });

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;
    final configProvider = Provider.of<ConfigurationProvider>(context);

    return Container(
      height: height,
      color: CustomColors.ButtonEnabledAction,
      child: (menudisplay == false)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //title
                Padding(
                  padding: EdgeInsets.only(
                    top: currentSize.height * 0.05,
                    left: currentSize.width * 0.02,
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Montserrat,SemiBold',
                      color: CustomColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.060,
                      // Aquí puedes ajustar el tamaño del texto en función del ancho de la pantalla.
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: currentSize.height * 0.05,
                    right: currentSize.width * 0.04,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InformationUserPage()),
                      );
                    },
                    child: Container(
                      //color: Colors.green,
                      height: 50,
                      width: 50,
                      child: CircleAvatar(
                        radius: currentSize.width * 0.10,
                        backgroundImage: (configProvider.imageCropPhofile !=
                                null)
                            ? FileImage(
                                    File(configProvider.imageCropPhofile!.path))
                                as ImageProvider<Object>
                            : const AssetImage(Assets.avatarProfile),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Padding(
                      padding: EdgeInsets.only(
                        top: currentSize.height * 0.0,
                        left: currentSize.width * 0.01,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: CustomColors.white,
                        size: 30,
                      )),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: currentSize.height * 0.0,
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Montserrat,SemiBold',
                        color: CustomColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.060,
                        // Aquí puedes ajustar el tamaño del texto en función del ancho de la pantalla.
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
