import 'package:go_seo_servers/generated/json/base/json_convert_content.dart';
import 'package:go_seo_servers/model/src/template_model_entity.dart';

TemplateModelEntity $TemplateModelEntityFromJson(Map<String, dynamic> json) {
	final TemplateModelEntity templateModelEntity = TemplateModelEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		templateModelEntity.id = id;
	}
	final String? createdAt = jsonConvert.convert<String>(json['createdAt']);
	if (createdAt != null) {
		templateModelEntity.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updatedAt']);
	if (updatedAt != null) {
		templateModelEntity.updatedAt = updatedAt;
	}
	final String? domain = jsonConvert.convert<String>(json['domain']);
	if (domain != null) {
		templateModelEntity.domain = domain;
	}
	final String? tag = jsonConvert.convert<String>(json['tag']);
	if (tag != null) {
		templateModelEntity.tag = tag;
	}
	final int? collectType = jsonConvert.convert<int>(json['collect_type']);
	if (collectType != null) {
		templateModelEntity.collectType = collectType;
	}
	final int? createTime = jsonConvert.convert<int>(json['create_time']);
	if (createTime != null) {
		templateModelEntity.createTime = createTime;
	}
	final int? quote = jsonConvert.convert<int>(json['quote']);
	if (quote != null) {
		templateModelEntity.quote = quote;
	}
	return templateModelEntity;
}

Map<String, dynamic> $TemplateModelEntityToJson(TemplateModelEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	data['domain'] = entity.domain;
	data['tag'] = entity.tag;
	data['collect_type'] = entity.collectType;
	data['create_time'] = entity.createTime;
	data['quote'] = entity.quote;
	return data;
}