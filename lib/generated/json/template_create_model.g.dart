import 'package:go_seo_servers/generated/json/base/json_convert_content.dart';
import 'package:go_seo_servers/model/src/template_create_model.dart';

TemplateCreateModel $TemplateCreateModelFromJson(Map<String, dynamic> json) {
	final TemplateCreateModel templateCreateModel = TemplateCreateModel();
	final int? collectType = jsonConvert.convert<int>(json['collect_type']);
	if (collectType != null) {
		templateCreateModel.collectType = collectType;
	}
	final String? domain = jsonConvert.convert<String>(json['domain']);
	if (domain != null) {
		templateCreateModel.domain = domain;
	}
	return templateCreateModel;
}

Map<String, dynamic> $TemplateCreateModelToJson(TemplateCreateModel entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['collect_type'] = entity.collectType;
	data['domain'] = entity.domain;
	return data;
}