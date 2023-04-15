// To parse this JSON data, do
//
//     final locales = localesFromJson(jsonString);

import 'dart:convert';

Locales localesFromJson(String str) => Locales.fromJson(json.decode(str));

String localesToJson(Locales data) => json.encode(data.toJson());

class Locales {
    Locales({
        required this.locales,
    });

    List<Locale> locales;

    factory Locales.fromJson(Map<String, dynamic> json) => Locales(
        locales: List<Locale>.from(json["Locales"].map((x) => Locale.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Locales": List<dynamic>.from(locales.map((x) => x.toJson())),
    };
}

class Locale {
    Locale({
        required this.idLocal,
        required this.nombreLocal,
        required this.activo,
        required this.createdAt,
        required this.updatedAt,
    });

    int idLocal;
    String nombreLocal;
    bool activo;
    DateTime createdAt;
    DateTime updatedAt;

    factory Locale.fromJson(Map<String, dynamic> json) => Locale(
        idLocal: json["idLocal"],
        nombreLocal: json["nombreLocal"],
        activo: json["activo"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "idLocal": idLocal,
        "nombreLocal": nombreLocal,
        "activo": activo,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
