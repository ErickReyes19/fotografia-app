// To parse this JSON data, do
//
//     final paquetes = paquetesFromJson(jsonString);

import 'dart:convert';

Paquetes paquetesFromJson(String str) => Paquetes.fromJson(json.decode(str));

String paquetesToJson(Paquetes data) => json.encode(data.toJson());

class Paquetes {
    Paquetes({
        required this.paquetes,
    });

    List<Paquete> paquetes;

    factory Paquetes.fromJson(Map<String, dynamic> json) => Paquetes(
        paquetes: List<Paquete>.from(json["Paquetes"].map((x) => Paquete.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Paquetes": List<dynamic>.from(paquetes.map((x) => x.toJson())),
    };
}

class Paquete {
    Paquete({
        required this.idPaquete,
        required this.nombrePaquete,
        required this.catidadFotosDigitales,
        required this.fotosImpresas,
        required this.cantFotosImpresas,
        required this.tiempoCobertura,
        required this.precio,
        required this.activo,
    });

    int idPaquete;
    String nombrePaquete;
    int catidadFotosDigitales;
    bool fotosImpresas;
    int cantFotosImpresas;
    DateTime tiempoCobertura;
    int precio;
    bool activo;

    factory Paquete.fromJson(Map<String, dynamic> json) => Paquete(
        idPaquete: json["idPaquete"],
        nombrePaquete: json["nombrePaquete"],
        catidadFotosDigitales: json["catidadFotosDigitales"],
        fotosImpresas: json["fotosImpresas"],
        cantFotosImpresas: json["cantFotosImpresas"],
        tiempoCobertura: DateTime.parse(json["tiempoCobertura"]),
        precio: json["precio"],
        activo: json["activo"],
    );

    Map<String, dynamic> toJson() => {
        "idPaquete": idPaquete,
        "nombrePaquete": nombrePaquete,
        "catidadFotosDigitales": catidadFotosDigitales,
        "fotosImpresas": fotosImpresas,
        "cantFotosImpresas": cantFotosImpresas,
        "tiempoCobertura": tiempoCobertura.toIso8601String(),
        "precio": precio,
        "activo": activo,
    };
}
