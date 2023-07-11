import 'package:go_seo_servers/model/src/response/json_field.dart';
import 'package:go_seo_servers/generated/json/template_model_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class TemplateModelEntity {
  late int id;
  late String createdAt;
  late String updatedAt;
  late String domain;
  late String tag;
  @JSONField(name: "collect_type")
  late int collectType;
  @JSONField(name: "create_time")
  late int createTime;
  late int quote;

  TemplateModelEntity();

  factory TemplateModelEntity.fromJson(Map<String, dynamic> json) =>
      $TemplateModelEntityFromJson(json);

  Map<String, dynamic> toJson() => $TemplateModelEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
