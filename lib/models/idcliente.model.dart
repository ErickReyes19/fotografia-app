import 'dart:convert';

IdCliente idClienteFromJson(String str) => IdCliente.fromJson(json.decode(str));

String idClienteToJson(IdCliente data) => json.encode(data.toJson());

class IdCliente {
    IdCliente({
        this.idcliente,
    });

    int? idcliente;

    factory IdCliente.fromJson(Map<String, dynamic> json) => IdCliente(
        idcliente: json["idcliente"],
    );

    Map<String, dynamic> toJson() => {
        "idcliente": idcliente,
    };
}
