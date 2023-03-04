import 'dart:convert';

import 'package:acuacar_app/models/user_register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../enviroment/enviroment.dart';

class RegisteFromProvider extends ChangeNotifier {

  
  GlobalKey<FormState> formRegistergKey =  GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';

  bool isValidForm(){
    print(formRegistergKey.currentState?.validate());
    return formRegistergKey.currentState?.validate() ?? false;
  }


  Future<bool> registrarUsuario(name, email, password) async {

    final data = {
      "nombre": name,
      "email": email,
      "contrasenia": password
    };
  

    var url = Uri.parse('${Enviroment.apiUrl}/Usuario/Registro');

    final response = await http.post(url,
    body : jsonEncode(data),
    headers: {
        'Content-type': 'application/json'
      }
    );

    if (response.statusCode == 200) {
      print('se hizo la peticion');
      print(response.body);
      print(url);
      try {
       final newResponse = UsuarioRegister.fromJson(response.body);
       return true;
      } catch (e) {
        return false;
      }
    } else {
      throw Exception('Failed to load forecasts');
    }
    

  }



}