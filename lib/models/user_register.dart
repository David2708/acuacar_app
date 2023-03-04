// To parse this JSON data, do
//
//     final usuarioRegister = usuarioRegisterFromMap(jsonString);

import 'dart:convert';

class UsuarioRegister {
    UsuarioRegister({
        required this.mensaje,
        required this.usuarioCreado,
    });

    String mensaje;
    UsuarioCreado usuarioCreado;

    factory UsuarioRegister.fromJson(String str) => UsuarioRegister.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UsuarioRegister.fromMap(Map<String, dynamic> json) => UsuarioRegister(
        mensaje: json["mensaje"],
        usuarioCreado: UsuarioCreado.fromMap(json["usuarioCreado"]),
    );

    Map<String, dynamic> toMap() => {
        "mensaje": mensaje,
        "usuarioCreado": usuarioCreado.toMap(),
    };
}

class UsuarioCreado {
    UsuarioCreado({
        required this.idUsuario,
        required this.nombre,
        required this.email,
        required this.contrasenia,
    });

    int idUsuario;
    String nombre;
    String email;
    String contrasenia;

    factory UsuarioCreado.fromJson(String str) => UsuarioCreado.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UsuarioCreado.fromMap(Map<String, dynamic> json) => UsuarioCreado(
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
