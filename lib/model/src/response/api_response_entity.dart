import 'package:go_seo_servers/model/src/response/api_response_entity.g.dart';
import 'dart:convert';

class ApiResponseEntity<T> {
  late int code;
  late T data;
  late String msg;

  ApiResponseEntity();

  factory ApiResponseEntity.fromJson(Map<String, dynamic> json) =>
      $ApiResponseEntityFromJson<T>(json);

  Map<String, dynamic> toJson() => $ApiResponseEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
