import 'package:go_seo_servers/model/src/response/json_field.dart';
import 'package:go_seo_servers/generated/json/template_create_model.g.dart';
import 'dart:convert';

@JsonSerializable()
class TemplateCreateModel {
  @JSONField(name: "collect_type")
  int? collectType;
  String? domain;

  TemplateCreateModel();

  factory TemplateCreateModel.fromJson(Map<String, dynamic> json) =>
      $TemplateCreateModelFromJson(json);

  Map<String, dynamic> toJson() => $TemplateCreateModelToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
