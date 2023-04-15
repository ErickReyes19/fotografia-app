// To parse this JSON data, do
//
//     final clientes = clientesFromJson(jsonString);

import 'dart:convert';

Clientes clientesFromJson(String str) => Clientes.fromJson(json.decode(str));

String clientesToJson(Clientes data) => json.encode(data.toJson());

class Clientes {
    Clientes({
        required this.clientes,
    });

    List<Cliente> clientes;

    factory Clientes.fromJson(Map<String, dynamic> json) => Clientes(
        clientes: List<Cliente>.from(json["Clientes"].map((x) => Cliente.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Clientes": List<dynamic>.from(clientes.map((x) => x.toJson())),
    };
}

class Cliente {
    Cliente({
        required this.idCliente,
        required this.nombre,
        required this.numerocelular,
        required this.identidad,
        required this.activo,
    });

    int idCliente;
    String nombre;
    String numerocelular;
    String identidad;
    bool activo;

    factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        idCliente: json["idCliente"],
        nombre: json["nombre"],
        numerocelular: json["numerocelular"],
        identidad: json["identidad"],
        activo: json["activo"],
    );

    Map<String, dynamic> toJson() => {
        "idCliente": idCliente,
        "nombre": nombre,
        "numerocelular": numerocelular,
        "identidad": identidad,
        "activo": activo,
    };
}
