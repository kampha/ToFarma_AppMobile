import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:to_farma_app/core/models/models.dart';
import 'package:to_farma_app/core/server/server.dart';
import 'package:http/http.dart' as http;
import 'package:to_farma_app/core/shared_preferences/preferences_user.dart';

class MensajesServices extends ChangeNotifier {
  final String prefix = LaravelConfig.prefix;
  final config = LaravelConfig();
  final List<Mensaje> mensajes = [];
  final List<ChatMessage> messagesLst = [];

  Future<List<ChatMessage>> getMensajes() async {
    messagesLst.clear();
    notifyListeners();
    final url = Uri.https(LaravelConfig.baseUrl, '$prefix/patient/messages');
    final respuesta = await http.get(url,
        headers: config.header(SharedPreferencesService.getToken));
    if (respuesta.body != '[]' && respuesta.statusCode == 200) {
      final resp = mensajeFromJson(respuesta.body);
      final List<ChatMessage> mesajes = [];
      for (var element in resp) {
        ChatUser usuario = ChatUser(
            id: element.senderId.toString(),
            profileImage:
                'https://${LaravelConfig.baseUrl}/storage/${element.sender!.avatar}');
        mesajes.insert(
            0,
            ChatMessage(
                user: usuario,
                createdAt: element.createdAt,
                text: element.text));
        notifyListeners();
      }
      return mesajes;
    }
    notifyListeners();
    return messagesLst;
  }

  Future newMensajes(String msg) async {
    messagesLst.clear();
    notifyListeners();
    final url = Uri.https(LaravelConfig.baseUrl, '$prefix/patient/messages');
    final respuesta = await http.post(url,
        headers: config.header(SharedPreferencesService.getToken),
        body: {'text': msg});
    if (respuesta.statusCode == 200) {
      getMensajes();
    }
    notifyListeners();
  }
}
