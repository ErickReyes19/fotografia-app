// To parse this JSON data, do
//
//     final categorias = categoriasFromJson(jsonString);

import 'dart:convert';

Categorias categoriasFromJson(String str) => Categorias.fromJson(json.decode(str));

String categoriasToJson(Categorias data) => json.encode(data.toJson());

class Categorias {
    Categorias({
        required this.categorias,
    });

    List<Categoria> categorias;

    factory Categorias.fromJson(Map<String, dynamic> json) => Categorias(
        categorias: List<Categoria>.from(json["categorias"].map((x) => Categoria.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categorias": List<dynamic>.from(categorias.map((x) => x.toJson())),
    };
}

class Categoria {
    Categoria({
        required this.idCategoria,
        required this.idServicio,
        required this.tipoCategoria,
        required this.activo,
    });

    int idCategoria;
    int idServicio;
    String tipoCategoria;
    bool activo;

    factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        idCategoria: json["idCategoria"],
        idServicio: json["idServicio"],
        tipoCategoria: json["tipoCategoria"],
        activo: json["activo"],
    );

    Map<String, dynamic> toJson() => {
        "idCategoria": idCategoria,
        "idServicio": idServicio,
        "tipoCategoria": tipoCategoria,
        "activo": activo,
    };
}
