import 'package:go_seo_servers/generated/json/base/json_field.dart';
import 'package:go_seo_servers/generated/json/content_model_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class ContentModelEntity {
	late String path;
	late String name;
	late String user;
	late String group;
	late String extension;
	late String content;
	late int size;
	late bool isDir;
	late bool isSymlink;
	late bool isHidden;
	late String linkPath;
	late String type;
	late String mode;
	late String mimeType;
	late String updateTime;
	late String modTime;
	dynamic items;
	late int itemTotal;

	ContentModelEntity();

	factory ContentModelEntity.fromJson(Map<String, dynamic> json) => $ContentModelEntityFromJson(json);

	Map<String, dynamic> toJson() => $ContentModelEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}