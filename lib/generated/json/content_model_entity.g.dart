import 'package:go_seo_servers/generated/json/base/json_convert_content.dart';
import 'package:go_seo_servers/model/src/content_model_entity.dart';

ContentModelEntity $ContentModelEntityFromJson(Map<String, dynamic> json) {
	final ContentModelEntity contentModelEntity = ContentModelEntity();
	final String? path = jsonConvert.convert<String>(json['path']);
	if (path != null) {
		contentModelEntity.path = path;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		contentModelEntity.name = name;
	}
	final String? user = jsonConvert.convert<String>(json['user']);
	if (user != null) {
		contentModelEntity.user = user;
	}
	final String? group = jsonConvert.convert<String>(json['group']);
	if (group != null) {
		contentModelEntity.group = group;
	}
	final String? extension = jsonConvert.convert<String>(json['extension']);
	if (extension != null) {
		contentModelEntity.extension = extension;
	}
	final String? content = jsonConvert.convert<String>(json['content']);
	if (content != null) {
		contentModelEntity.content = content;
	}
	final int? size = jsonConvert.convert<int>(json['size']);
	if (size != null) {
		contentModelEntity.size = size;
	}
	final bool? isDir = jsonConvert.convert<bool>(json['isDir']);
	if (isDir != null) {
		contentModelEntity.isDir = isDir;
	}
	final bool? isSymlink = jsonConvert.convert<bool>(json['isSymlink']);
	if (isSymlink != null) {
		contentModelEntity.isSymlink = isSymlink;
	}
	final bool? isHidden = jsonConvert.convert<bool>(json['isHidden']);
	if (isHidden != null) {
		contentModelEntity.isHidden = isHidden;
	}
	final String? linkPath = jsonConvert.convert<String>(json['linkPath']);
	if (linkPath != null) {
		contentModelEntity.linkPath = linkPath;
	}
	final String? type = jsonConvert.convert<String>(json['type']);
	if (type != null) {
		contentModelEntity.type = type;
	}
	final String? mode = jsonConvert.convert<String>(json['mode']);
	if (mode != null) {
		contentModelEntity.mode = mode;
	}
	final String? mimeType = jsonConvert.convert<String>(json['mimeType']);
	if (mimeType != null) {
		contentModelEntity.mimeType = mimeType;
	}
	final String? updateTime = jsonConvert.convert<String>(json['updateTime']);
	if (updateTime != null) {
		contentModelEntity.updateTime = updateTime;
	}
	final String? modTime = jsonConvert.convert<String>(json['modTime']);
	if (modTime != null) {
		contentModelEntity.modTime = modTime;
	}
	final dynamic items = jsonConvert.convert<dynamic>(json['items']);
	if (items != null) {
		contentModelEntity.items = items;
	}
	final int? itemTotal = jsonConvert.convert<int>(json['itemTotal']);
	if (itemTotal != null) {
		contentModelEntity.itemTotal = itemTotal;
	}
	return contentModelEntity;
}

Map<String, dynamic> $ContentModelEntityToJson(ContentModelEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['path'] = entity.path;
	data['name'] = entity.name;
	data['user'] = entity.user;
	data['group'] = entity.group;
	data['extension'] = entity.extension;
	data['content'] = entity.content;
	data['size'] = entity.size;
	data['isDir'] = entity.isDir;
	data['isSymlink'] = entity.isSymlink;
	data['isHidden'] = entity.isHidden;
	data['linkPath'] = entity.linkPath;
	data['type'] = entity.type;
	data['mode'] = entity.mode;
	data['mimeType'] = entity.mimeType;
	data['updateTime'] = entity.updateTime;
	data['modTime'] = entity.modTime;
	data['items'] = entity.items;
	data['itemTotal'] = entity.itemTotal;
	return data;
}