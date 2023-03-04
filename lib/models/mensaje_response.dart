// To parse this JSON data, do
//
//     final mensaje = mensajeFromMap(jsonString);

import 'dart:convert';

class MensajeResponse {
    MensajeResponse({
        required this.mensaje,
    });

    String mensaje;

    factory MensajeResponse.fromJson(String str) => MensajeResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MensajeResponse.fromMap(Map<String, dynamic> json) => MensajeResponse(
        mensaje: json["mensaje"],
    );

    Map<String, dynamic> toMap() => {
        "mensaje": mensaje,
    };
}
