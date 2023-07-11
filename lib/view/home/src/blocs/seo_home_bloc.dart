import 'package:flutter/cupertino.dart';
import 'package:go_seo_servers/components/components.dart';
import 'package:go_seo_servers/routers/routers.dart';

class SEOHomeBloc with BodyMixin {
  int selectIndex = 0;
  Map<String, dynamic>? queryParameters;
  PagesScope pageScope = PagesScope();
  List<ITabBarModel> get model => [
        ITabBarModel(
          AppRouters.templateNamed,
          title: "模板管理",
          icon: CupertinoIcons.globe,
        ),
        ITabBarModel(
          AppRouters.editTemplateNamed,
          title: "编辑模板",
          icon: CupertinoIcons.tray_arrow_down,
        ),
      ];

  void onTaber(int index, String? namePath) {
    selectIndex = index;
    onIndex(selectIndex);
    pageScope.update();
  }

  void onIndex(int index) async {
    var sp = await SpUtil.getInstance();
    sp?.putInt("index", index);
  }

  @override
  Future onInit() async {
    var sp = await SpUtil.getInstance();
    var selectInde = sp?.getInt("index");
    selectIndex = selectInde ?? 0;
    return selectIndex;
  }
}
