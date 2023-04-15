import 'dart:convert';

MsgApi msgApiFromJson(String str, bool aplicaAlert) =>
    MsgApi.fromJson(json.decode(str), aplicaAlert);

String msgApiToJson(MsgApi data) => json.encode(data.toJson());

class MsgApi {
  MsgApi({this.msg, this.ok, this.errors, required this.aplicaAlert});

  String? msg;
  bool? ok;
  List<String>? errors;
  bool aplicaAlert;

  factory MsgApi.fromJson(Map<String, dynamic> json, bool aplicaAlert) =>
      MsgApi(
          msg: json["msg"],
          ok: json["ok"],
          errors: json["errors"] == null
              ? []
              : List<String>.from(json["errors"]!.map((x) => x)),
          aplicaAlert: aplicaAlert);

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "ok": ok,
        "errors":
            errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
      };
}
