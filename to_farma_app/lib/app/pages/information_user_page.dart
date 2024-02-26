import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:to_farma_app/app/pages/login_page.dart';
import 'package:to_farma_app/app/widgets/widgets.dart';
import 'package:to_farma_app/core/models/user.dart';
import 'package:to_farma_app/core/providers/providers.dart';
import 'package:to_farma_app/core/services/services.dart';
import 'package:to_farma_app/core/utlis/assets.dart';
import 'package:to_farma_app/core/utlis/custom_colors.dart';

import '../../core/models/data.dart';

class InformationUserPage extends StatelessWidget {
  const InformationUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;

    final configProvider = Provider.of<ConfigurationProvider>(context);
    final userGet = Provider.of<UsersServices>(context);
    final loagingProvider = Provider.of<LoadingProviders>(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppBarMenu(
              menudisplay: true,
              height: currentSize.height * 0.20,
              title: 'Perfil '),
          Transform.translate(
            offset: const Offset(0, -70),
            child: Center(
              child: Stack(
                children: [
                  Container(
                    //color: Colors.green,
                    height: 100,
                    width: 100,
                    child: CircleAvatar(
                      radius: currentSize.width * 0.18,
                      backgroundImage: (configProvider.imageCropPhofile != null)
                          ? FileImage(
                                  File(configProvider.imageCropPhofile!.path))
                              as ImageProvider<Object>
                          : const AssetImage(Assets.avatarProfile),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: currentSize.height * 0.62,
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
            child: SingleChildScrollView(
                child: Column(
              children: [
                const BodyInformation(),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: ButtonActionWidget(
                    function: () {
                      loagingProvider.isLoading = true;
                      userGet.deleteInfo();

                      Navigator.of(context, rootNavigator: true)
                          .pushAndRemoveUntil(
                              CupertinoPageRoute(
                                  builder: (context) => const LoginPage()),
                              (route) => false);

                      loagingProvider.isLoading = false;
                    },
                    titleButton: 'Cerrar session',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}

class BodyInformation extends StatelessWidget {
  const BodyInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userGet = Provider.of<UsersServices>(context).getInfo();
    return Container(
      child: FutureBuilder<User>(
        future: userGet,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                cardInformation(
                  icon: Icons.card_membership,
                  title: 'Cédula',
                  texto: snapshot.data!.identification,
                ),
                cardInformation(
                  icon: Icons.person_pin,
                  title: 'Nombre',
                  texto: snapshot.data!.name,
                ),
                cardInformation(
                  icon: Icons.email,
                  title: 'Correo electrónico',
                  texto: snapshot.data!.email,
                ),
                cardInformation(
                  icon: Icons.healing,
                  title: 'Adherencia',
                  texto: snapshot.data!.adherenceCategorisation,
                ),
                cardInformation(
                  icon: Icons.thermostat,
                  title: 'Puntuaje de adhrencia',
                  texto: '${snapshot.data!.adherenceValue.toString()} %',
                ),
                cardInformation(
                  icon: Icons.health_and_safety_rounded,
                  title: 'Diagnóstico',
                  texto: snapshot.data!.diagnosticCategorisation.toString(),
                ),
                cardInformation(
                  icon: Icons.medical_services,
                  title: 'Puntuaje de diagnóstico ',
                  texto: '${snapshot.data!.diagnosticValue.toString()} %',
                ),
                Row(
                  children: [
                    SwitchNotif(
                      activo: snapshot.data!.medicationNotify == 1,
                    ),
                    Text('Alertas',
                        style: TextStyle(
                          fontFamily: 'Montserrat,SemiBold',
                          color: CustomColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.050,
                          // Aquí puedes ajustar el tamaño del texto en función del ancho de la pantalla.
                        )),
                  ],
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // Por defecto, muestra un indicador de progreso
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class cardInformation extends StatelessWidget {
  final String title;
  final String texto;
  final IconData icon;

  const cardInformation(
      {super.key,
      required this.title,
      required this.texto,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Montserrat,SemiBold',
                  color: CustomColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.050,
                  // Aquí puedes ajustar el tamaño del texto en función del ancho de la pantalla.
                ),
              ),
              Text(
                texto,
                style: TextStyle(
                  fontFamily: 'Montserrat,SemiBold',
                  color: CustomColors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: MediaQuery.of(context).size.width * 0.040,
                  // Aquí puedes ajustar el tamaño del texto en función del ancho de la pantalla.
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SwitchNotif extends StatefulWidget {
  final bool activo;
  const SwitchNotif({super.key, required this.activo});

  @override
  State<SwitchNotif> createState() => _SwitchNotifyState(light: activo);
}

class _SwitchNotifyState extends State<SwitchNotif> {
  bool light;
  _SwitchNotifyState({required this.light});
  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: CustomColors.buttonAlert,
      onChanged: (bool value) async {
        // This is called when the user toggles the switch.
        setState(() {
          QuickAlert.show(
              context: context,
              type: QuickAlertType.confirm,
              title: 'Notificar',
              text:
                  '¿Desea que TöFarma le notifique la toma de los medicamentos?',
              confirmBtnText: 'Si, Notificar',
              cancelBtnText: 'No',
              confirmBtnColor: Colors.green,
              confirmBtnTextStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              customAsset: Assets.logoTofarma,
              onConfirmBtnTap: () async {
                light = value;
                final result =
                    await userGetInfor.changeMedicationNotify(value ? 1 : 0);
                if (result) {
                  int notificacion = value ? 1 : 0;
                  await userGetInfor.storage.write(
                      key: "idmedicationNotifyUser",
                      value: notificacion.toString());
                }
                /*if (futureResponse.respuesta) {
                await QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: 'Configuración',
                  text: medicacion.message,
                  autoCloseDuration: const Duration(seconds: 10),
                );
              } else {
                await QuickAlert.show(
                  context: context,
                  type: QuickAlertType.info,
                  title: 'Configuración',
                  text: futureResponse.mensaje,
                  backgroundColor: Colors.black,
                  titleColor: Colors.white,
                  textColor: Colors.white,
                );
              }*/
              },
              onCancelBtnTap: () async {
                light = value ? false : true;
              });
        });
      },
    );
  }
}
