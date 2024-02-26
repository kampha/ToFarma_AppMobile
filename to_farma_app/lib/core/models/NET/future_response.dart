class FutureResponse {
  bool respuesta;
  dynamic mensaje;
  dynamic model;

  FutureResponse({required this.respuesta, this.mensaje, model});

  Map<String, dynamic> toJson() => {
        "respuesta": respuesta,
        "mensaje": mensaje,
        "model": model,
      };
}
