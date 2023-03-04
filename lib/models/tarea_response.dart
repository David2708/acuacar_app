// To parse this JSON data, do
//
//     final tareaResponse = tareaResponseFromMap(jsonString);

import 'dart:convert';

class TareaResponse {
    TareaResponse({
        required this.mensaje,
        required this.response,
    });

    String mensaje;
    List<Tarea> response;

    factory TareaResponse.fromJson(String str) => TareaResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TareaResponse.fromMap(Map<String, dynamic> json) => TareaResponse(
        mensaje: json["mensaje"],
        response: List<Tarea>.from(json["response"].map((x) => Tarea.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "mensaje": mensaje,
        "response": List<dynamic>.from(response.map((x) => x.toMap())),
    };
}

class Tarea {
    Tarea({
        required this.idTarea,
        required this.idUsuario,
        required this.nombreTarea,
    });

    int idTarea;
    int idUsuario;
    String nombreTarea;

    factory Tarea.fromJson(String str) => Tarea.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Tarea.fromMap(Map<String, dynamic> json) => Tarea(
        idTarea: json["idTarea"],
        idUsuario: json["idUsuario"],
        nombreTarea: json["nombreTarea"],
    );

    Map<String, dynamic> toMap() => {
        "idTarea": idTarea,
        "idUsuario": idUsuario,
        "nombreTarea": nombreTarea,
    };
}
