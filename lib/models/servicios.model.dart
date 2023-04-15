// To parse this JSON data, do
//
//     final servicios = serviciosFromJson(jsonString);

import 'dart:convert';

Servicios serviciosFromJson(String str) => Servicios.fromJson(json.decode(str));

String serviciosToJson(Servicios data) => json.encode(data.toJson());

class Servicios {
    Servicios({
        required this.servicios,
    });

    List<Servicio> servicios;

    factory Servicios.fromJson(Map<String, dynamic> json) => Servicios(
        servicios: List<Servicio>.from(json["Servicios"].map((x) => Servicio.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Servicios": List<dynamic>.from(servicios.map((x) => x.toJson())),
    };
}

class Servicio {
    Servicio({
        required this.idServicio,
        required this.tipoServicio,
        required this.activo,
        required this.createdAt,
        required this.updatedAt,
    });

    int idServicio;
    String tipoServicio;
    bool activo;
    DateTime createdAt;
    DateTime updatedAt;

    factory Servicio.fromJson(Map<String, dynamic> json) => Servicio(
        idServicio: json["idServicio"],
        tipoServicio: json["tipoServicio"],
        activo: json["activo"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "idServicio": idServicio,
        "tipoServicio": tipoServicio,
        "activo": activo,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
