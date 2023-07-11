import 'package:dio/dio.dart';
import 'package:go_seo_servers/model/model.dart';
import 'package:go_seo_servers/net-work/request.dart';

class HomeRequest {
  static Dio dio = Dio(
    BaseOptions(
      headers: {
        "Access-Control-Allow-Origin": '*',
        "Access-Control-Allow-Credentials": true,
      },
    ),
  );

  static Future<dynamic> postTpCreate({
    TemplateCreateModel? param,
  }) async {
    try {
      var json = await requestClient.post(
        APIS.tpCreate,
        data: param,
      );
      return json;
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> getTpCreate({
    String? domain,
    int ua = 0,
  }) async {
    try {
      var json = await requestClient.get(
        "${APIS.template}/:$domain/:$ua",
      );
      print(json);
      return json;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<TemplateModelEntity>?> postTemplate({
    required int page,
  }) async {
    try {
      var params = {
        "page": page,
        "pageSize": 500,
      };
      var json = await requestClient.post(
        APIS.template,
        data: params,
      );
      List<dynamic> lsit = json["items"];
      return lsit.map((e) => TemplateModelEntity.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> postDelete({
    required int id,
    String? name,
  }) async {
    try {
      var params = {
        "id": id,
      };
      var json = await requestClient.post(
        APIS.tpDel,
        data: params,
      );

      return json;
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> postTag({
    required int id,
    String? name,
  }) async {
    try {
      var params = {
        "id": id,
        "tag": name,
      };
      var json = await requestClient.post(
        APIS.tpTag,
        data: params,
      );

      return json;
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> postQuote({
    required int id,
    int? index,
  }) async {
    try {
      var params = {
        "id": id,
        "quote": index,
      };
      var json = await requestClient.post(
        APIS.tpQuote,
        data: params,
      );
      return json;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<dynamic>> postSeatch({
    required String name,
  }) async {
    try {
      var params = {
        "page_name": name,
      };
      var json = await requestClient.post(
        APIS.tpSearch,
        data: params,
      );
      return json;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ContentModelEntity> postContent({
    required String name,
  }) async {
    try {
      var params = {
        "path": name,
        "dir": false,
        "containSub": true,
        "expand": true,
        "page": 0,
        "pageSize": 0,
        "search": "",
        "showHidden": true
      };
      var json = await requestClient.post(
        APIS.tpContent,
        data: params,
      );
      var path = ContentModelEntity.fromJson(json);
      return path;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ContentModelEntity> postSave({
    required String name,
    required String path,
  }) async {
    try {
      var params = {
        "path": path,
        "content": name,
      };
      var json = await requestClient.post(
        APIS.tpSave,
        data: params,
      );
      var model = ContentModelEntity.fromJson(json);
      return model;
    } catch (e) {
      rethrow;
    }
  }
}
