import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_seo_servers/components/components.dart';
import 'package:go_seo_servers/model/model.dart';
import 'package:go_seo_servers/net-work/src/api/src/home_request.dart';
import 'package:go_seo_servers/view/seo.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class TemplateBloc with BodyMixin<List<TemplateModelEntity>?> {
  ///模板数据
  List<TemplateModelEntity>? templateList;

  ///更新
  UpdateScope scope = UpdateScope();

  ///表格行数
  int rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  ///url
  TextEditingController? domainController = TextEditingController();
  TextEditingController? tagController = TextEditingController();
  TextEditingController? countController = TextEditingController();

  ///终端类型初始
  HttpOption groupValueOption = HttpOption.option3;

  double sliderValue = 1;
  late int type;

  ///模板标题类型
  List<String> titleList = [
    "模板",
    "模板标签",
    "终端类型",
    "克隆时间",
    "使用次数",
    "操作",
  ];

  ///终端类型
  List<ITextRadioModel> linksList = [
    ITextRadioModel(
      HttpOption.option0,
      "手机",
      0,
    ),
    ITextRadioModel(
      HttpOption.option1,
      "pc",
      1,
    ),
    ITextRadioModel(
      HttpOption.option2,
      "自适应",
      2,
    ),
  ];
  void onSlider(double value) {
    sliderValue = value;
    countController?.text = "$value";
    scope.update();
  }

  @override
  Future<List<TemplateModelEntity>?> onInit() async {
    templateList = [];
    templateList = await HomeRequest.postTemplate(page: 1);
    controller.withData(templateList);
    return templateList;
  }

  String? urlName;
  void onOpenUrl(String? domain) async {
    try {
      UX.show();
      urlName = domain;
      int ua = 0;
      await HomeRequest.getTpCreate(
        domain: domain,
        ua: ua,
      );
      html.window.open(
        'http://156.233.143.202:5000',
        'new tab',
      );
      await onInit();
      UX.hidden();
    } catch (e) {
      UX.hidden();
    }
  }

  void onPerPage(int? newRowsPerPage) {
    if (newRowsPerPage != null) {
      rowsPerPage = newRowsPerPage;
    }
    scope.update();
  }

  ///终端类型事件
  void onRadio(dynamic value, int types) {
    groupValueOption = value!;
    type = types;
    scope.update();
  }

  void onAddTemplate() async {
    try {
      TemplateCreateModel model = TemplateCreateModel();
      model.domain = domainController?.text;
      model.collectType = type;
      UX.show();
      var msg = await HomeRequest.postTpCreate(param: model);
      await onInit();
      UX.hidden();
      IToast.show("$msg");
      domainController?.clear();
      groupValueOption = HttpOption.option3;
    } catch (e) {
      UX.hidden();
      UX.toast(e.toString());
    }
  }

  void onTag(int id) async {
    try {
      int ids = id;
      String name = tagController?.text ?? "";
      UX.show();
      await HomeRequest.postTag(
        id: ids,
        name: name,
      );
      if (name.isNotEmpty) {
        publishEvent.fire(CrewCertCountEvent(name));
      }
      await onInit();
      UX.hidden();
      IToast.show("修改成功");
      scope.update();
      tagController?.clear();
    } catch (e) {
      UX.hidden();
      UX.toast(e.toString());
    }
  }

  void onQuote(int id) async {
    try {
      int ids = id;
      int index = int.parse(countController?.text ?? "0");
      UX.show();
      await HomeRequest.postQuote(
        id: ids,
        index: index,
      );
      await onInit();
      UX.hidden();
      IToast.show("修改成功");

      scope.update();
      countController?.clear();
    } catch (e) {
      UX.hidden();
      UX.toast(e.toString());
    }
  }

  void onDelete(int id) async {
    try {
      int sid = id;
      UX.show();
      await HomeRequest.postDelete(
        id: sid,
      );
      await onInit();
      UX.hidden();
      IToast.show("删除成功");
      scope.update();
    } catch (e) {
      UX.hidden();
      UX.toast(e.toString());
    }
  }

  ///添加模板库弹窗
  void openTemplateDialog(
    BuildContext context,
    Widget? child,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "添加模板",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25,
              width: 25,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(
                  Icons.close,
                  size: 22,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
        titleTextStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        content: child,
        actions: <Widget>[
          VariousStatelessButton(
            onPressed: () => Navigator.of(context).pop(),
            color: Colors.white,
            textColor: Colors.black,
            title: "取消",
            border: const BorderSide(width: 0.5, color: Colors.grey),
          ),
          VariousStatelessButton(
            onPressed: () {
              onAddTemplate();
              context.pop();
              scope.update();
            },
            color: const Color.fromARGB(255, 33, 82, 243),
            textColor: Colors.white,
            title: "确定",
          ),
        ],
      ),
    );
  }

  Future launchURL(url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ///编辑标签
  ///编辑标签
  Future<bool?> onTagDialog(
    BuildContext context,
    Widget child,
    int id,
  ) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return IShowDialog(
            value: scope,
            title: "修改标签",
            onPressed: () {
              onTag(id);
              Navigator.of(context).pop();
            },
            child: child,
          );
        });
  }

  ///编辑引用数
  Future<bool?> onQuoteDialog(
    BuildContext context,
    Widget child,
    int id,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return IShowDialog(
          value: scope,
          title: "修改引用数",
          onPressed: () {
            onQuote(id);
            Navigator.of(context).pop();
          },
          child: child,
        );
      },
    );
  }

  ///删除模板库
  Future<bool?> onDeleteDialog(
    BuildContext context,
    int id,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return IShowDialog(
          value: scope,
          title: "修改引用数",
          onPressed: () {
            onDelete(id);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
