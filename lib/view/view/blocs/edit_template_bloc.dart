import 'package:flutter/material.dart';
import 'package:go_seo_servers/components/components.dart';
import 'package:go_seo_servers/model/model.dart';
import 'package:go_seo_servers/net-work/src/api/api.dart';

class EditTemplateBloc with BodyMixin<List<dynamic>?> {
  PagesScope pageScope = PagesScope();

  List<dynamic>? searchList;

  List<dynamic>? pagesLsit;

  ContentModelEntity? pathPage;

  int pageIndex = 0;

  MenuController? menusController;

  String? path;

  ///查询
  final TextEditingController searchController = TextEditingController();
  final TextEditingController editController = TextEditingController();

  @override
  Future<List<dynamic>?> onInit() async {
    pageIndex = 0;
    searchList = [];
    await onLoading();
    return searchList;
  }

  @override
  Future<List<dynamic>?> onLoading() async {
    var taberList = await HomeRequest.postSeatch(name: "00");
    searchList = taberList;
    return searchList;
  }

  void onSearch(MenuController menuController) async {
    try {
      pagesLsit = [];
      UX.show();
      List<dynamic> pageLsit = await HomeRequest.postSeatch(
        name: searchController.text,
      );
      pagesLsit = pageLsit;
      menuController.open();
      menusController = menuController;
      pageScope.update();
      UX.hidden();
    } catch (e) {
      UX.hidden();
      UX.toast(e.toString());
    }
  }

  void onMenu(String e) async {
    try {
      UX.show();
      ContentModelEntity model = await HomeRequest.postContent(
        name: e,
      );
      editController.text = model.content;
      path = model.path;
      menusController?.close();
      pageScope.update();
      UX.hidden();
    } catch (e) {
      UX.hidden();
      UX.toast(e.toString());
    }
  }

  void onSubmit() async {
    try {
      UX.show();
      await HomeRequest.postSave(
        path: path!,
        name: editController.text,
      );

      menusController?.close();
      pageScope.update();
      UX.hidden();
      IToast.show("修改成功");
      editController.clear();
      searchController.clear();
    } catch (e) {
      UX.hidden();
      UX.toast(e.toString());
    }
  }
}
