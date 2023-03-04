// To parse this JSON data, do
//
//     final usuarioLogin = usuarioLoginFromMap(jsonString);

import 'dart:convert';

class UsuarioLogin {
    UsuarioLogin({
        required this.mensaje,
        required this.usuario,
    });

    String mensaje;
    Usuario usuario;

    factory UsuarioLogin.fromJson(String str) => UsuarioLogin.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UsuarioLogin.fromMap(Map<String, dynamic> json) => UsuarioLogin(
        mensaje: json["mensaje"],
        usuario: Usuario.fromMap(json["usuario"]),
    );

    Map<String, dynamic> toMap() => {
        "mensaje": mensaje,
        "usuario": usuario.toMap(),
    };
}

class Usuario {
    Usuario({
        required this.idUsuario,
        required this.nombre,
        required this.email,
        required this.contrasenia,
    });

    int idUsuario;
    String nombre;
    String email;
    String contrasenia;

    factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        idUsuario: json["idUsuario"],
        nombre: json["nombre"],
        email: json["email"],
        contrasenia: json["contrasenia"],
    );

    Map<String, dynamic> toMap() => {
        "idUsuario": idUsuario,
        "nombre": nombre,
        "email": email,
        "contrasenia": contrasenia,
    };
}
