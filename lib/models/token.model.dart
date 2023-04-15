import 'dart:convert';


Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
  Token({
    required this.token,
    //  required this.nombreUsuario
  });

  String token;
  // String nombreUsuario;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        token: json["token"],
        // nombreUsuario: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        // "nombre": nombreUsuario,
      };
}
