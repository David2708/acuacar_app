import 'dart:convert';

import 'package:acuacar_app/enviroment/enviroment.dart';
import 'package:acuacar_app/models/usuario_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formLoginKey =  GlobalKey<FormState>();

  String email = '';
  String password = '';

  late Usuario user ;
  

  bool isValidForm(){

    print(formLoginKey.currentState?.validate());
    return formLoginKey.currentState?.validate() ?? false;
    
  }

 
  Future<bool> validarCredenciales(email, password) async {

    final data = {
      "email": email,
      "contrasenia": password
    };
  

    var url = Uri.parse('${Enviroment.apiUrl}/Usuario/Ingresar');

    final response = await http.post(url,
    body : jsonEncode(data),
    headers: {
        'Content-type': 'application/json'
      }
    );

    if (response.statusCode == 200) {
      try {
       final newResponse = UsuarioLogin.fromJson(response.body);
       user = newResponse.usuario;
       return true;
      } catch (e) {
        return false;
      }
    } else {
      throw Exception('Failed to load forecasts');
    }
    

  }

}