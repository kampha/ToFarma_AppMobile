import 'dart:async';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:to_farma_app/app/components/componets.dart';
import 'package:to_farma_app/app/widgets/widgets.dart';
import 'package:to_farma_app/core/models/models.dart';
import 'package:to_farma_app/core/services/services.dart';
import 'package:to_farma_app/core/utlis/utlis.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BodyMessage createState() => _BodyMessage();
}

class _BodyMessage extends State<MessageScreen> {
  late List<ChatMessage> _mensajes = <ChatMessage>[];
  late String _phone;
  bool isFind = true;
  @override
  initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    userGetInfor.getInfo().then((value) => {
          user.id = value.id.toString(), //value.id.toString(),
          user.firstName = value.name,
          user.profileImage = value.avatar,
          _phone = value.phone
        });
    _mensajes = (await mensajesServices.getMensajes());
    isFind = false;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final mensajeService = Provider.of<MensajesServices>(context);
    //final List<ChatMessage> mensajes = mensajeService.messagesLst;

    final currentSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: CustomAppBarMenu(
          height: currentSize.height * 0.14,
          title: 'Habla con tu farmacéutico',
          menudisplay: false,
        ),
        body: _mensajes.isEmpty && isFind
            ? Center(child: LoadingProgress())
            : Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        Assets.imageWhatsapp,
                        fit: BoxFit.fill,
                        width: currentSize.width * 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: ButtonActionWidget(
                            function: () async {
                              if (_phone.isNotEmpty) {
                                FocusScope.of(context).unfocus();
                                await UrlLauncherCustom.openWhatsapp(
                                    context, _phone);
                              } else {
                                await QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.warning,
                                  title: 'WhatsApp',
                                  text:
                                      "No fue posible encontrar el número de teléfono",
                                  autoCloseDuration: const Duration(seconds: 4),
                                );
                              }
                            },
                            titleButton: 'Ir a WhatsApp'),
                      )
                    ],
                  ),
                  Flexible(
                    flex: 1, // ajusta esta propiedad según sea necesario
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: sizeChat(currentSize),
                        child: DashChat(
                          currentUser: user,
                          onSend: (ChatMessage m) {
                            setState(() {
                              mensajeService.newMensajes(m.text);
                              _mensajes.insert(0, m);
                            });
                          },
                          messages: _mensajes,
                          messageListOptions: MessageListOptions(
                            onLoadEarlier: () async {
                              await Future.delayed(const Duration(seconds: 3));
                            },
                          ),
                          inputOptions: InputOptions(
                              inputDecoration:
                                  InputDecorationCustom.getInputDecoration(
                                      hintext: 'Escribe el mensaje',
                                      prefixicon: const Icon(Icons.message),
                                      //suffixIcon: const Icon(Icons.send),
                                      context: context),
                              inputTextStyle:
                                  const TextStyle(color: Colors.black87)),
                        ),
                      ),
                    ),
                  ),
                ],
              ));
  }

  double sizeChat(Size currentSize) {
    if (currentSize.height < 700) return currentSize.height * 0.74;
    if (currentSize.height < 800) return currentSize.height * 0.75;
    return currentSize.height * 0.77;
  }
}

