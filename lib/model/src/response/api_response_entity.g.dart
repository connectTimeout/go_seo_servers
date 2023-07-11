import 'package:go_seo_servers/generated/json/base/json_convert_content.dart';
import 'package:go_seo_servers/model/src/response/api_response_entity.dart';

ApiResponseEntity<T> $ApiResponseEntityFromJson<T>(Map<String, dynamic> json) {
	final ApiResponseEntity<T> apiResponseEntity = ApiResponseEntity<T>();
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		apiResponseEntity.code = code;
	}
	final T? data = jsonConvert.convert<T>(json['data']);
	if (data != null) {
		apiResponseEntity.data = data;
	}
	final String? msg = jsonConvert.convert<String>(json['msg']);
	if (msg != null) {
		apiResponseEntity.msg = msg;
	}
	return apiResponseEntity;
}

Map<String, dynamic> $ApiResponseEntityToJson(ApiResponseEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['code'] = entity.code;
	data['data'] = entity.data;
	data['msg'] = entity.msg;
	return data;
}