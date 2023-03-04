import 'dart:convert';

import 'package:acuacar_app/models/mensaje_response.dart';
import 'package:acuacar_app/models/tarea_response.dart';
import '../enviroment/enviroment.dart';

import 'package:http/http.dart' as http;

class Services {
  static Future<String> crearTarea(nameTarea, idUsuario) async {
    final data = {"idUsuario": idUsuario, "nombreTarea": nameTarea};

    var url = Uri.parse('${Enviroment.apiUrl}/Tareas/crear-tarea');

    final response = await http.post(url,
        body: jsonEncode(data), headers: {'Content-type': 'application/json'});

    if (response.statusCode == 200) {
      final newResponse = MensajeResponse.fromJson(response.body);
      return newResponse.mensaje;
    } else {
      return 'Ha ocurrido un error';
    }
  }

  static Future<List<Tarea>> getTareas(idUsuario) async {
    var url =
        Uri.parse('${Enviroment.apiUrl}/Tareas/tareas-por-usuario/$idUsuario');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final tareas = TareaResponse.fromJson(response.body);
      return tareas.response;
    } else {
      final tareas = TareaResponse.fromJson(response.body);
      return tareas.response;
    }
  }

  static Future<String> guardarjecucion({
    idTarea, 
    idUsuario,
    fechaEjecucion,
    horaInicio,
    horaFin,
    duracion,
    observaciones
  }) async {

    final data = {
      "idTarea": idTarea,
      "idUsuario": idUsuario,
      "fechaEjecucion": fechaEjecucion,
      "horaInicio": horaInicio,
      "horaFin": horaFin,
      "duracion": duracion,
      "observaciones": observaciones
    };

    var url = Uri.parse('${Enviroment.apiUrl}/Ejecuciones/Registro');

    final response = await http.post(url,
        body: jsonEncode(data), 
        headers: {'Content-type': 'application/json'}
    );

    if (response.statusCode == 200) {
      final newResponse = MensajeResponse.fromJson(response.body);
      return newResponse.mensaje;
    } else {
      return 'Ha ocurrido un error';
    }
  }
}
