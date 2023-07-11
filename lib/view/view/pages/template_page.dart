import 'package:flutter/material.dart';
import 'package:go_seo_servers/components/components.dart';
import 'package:go_seo_servers/consts/consts.dart';
import 'package:go_seo_servers/model/model.dart';
import 'package:go_seo_servers/utils/utils.dart';
import 'package:go_seo_servers/view/seo.dart';
import 'package:provider/provider.dart';

class TemplatePage extends StatelessWidget {
  const TemplatePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<TemplateBloc>(context);

    return Body<List<TemplateModelEntity>?>(
      onInit: bloc.onInit,
      controller: bloc.controller,
      builder: (context, model) {
        int length = bloc.templateList?.length ?? 1;

        return ChangeNotifierProvider<UpdateScope>.value(
          value: bloc.scope,
          child: Consumer<UpdateScope>(builder: (_, scope, __) {
            return ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 5,
                      ),
                      child: VariousStatelessButton(
                        onPressed: () => bloc.openTemplateDialog(
                            context,
                            addTemplateCell(
                              bloc,
                            )),
                        color: Colors.blue,
                        textColor: Colors.white,
                        title: "添加模板",
                      ),
                    ),
                    CustomPaginatedTable(
                      titleList: bloc.titleList,
                      source: _DataTableChildren(
                        data: model ?? [],
                        onTap: (domain) => bloc.onOpenUrl(domain),
                        onTag: (id) {
                          bloc.onTagDialog(
                            context,
                            addTagCell(bloc),
                            id,
                          );
                        },
                        onQuote: (id) {
                          bloc.onQuoteDialog(
                            context,
                            addQuoteCell(bloc),
                            id,
                          );
                        },
                        onDelete: (id) {
                          bloc.onDeleteDialog(context, id);
                        },
                      ),
                      onRowsPerPageChanged: length < bloc.rowsPerPage
                          ? null
                          : (value) => bloc.onPerPage(value),
                      rowsPerPage:
                          length < bloc.rowsPerPage ? length : bloc.rowsPerPage,
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class _DataTableChildren extends DataTableSource {
  _DataTableChildren({
    required this.onTag,
    required this.onQuote,
    required this.onDelete,
    required this.onTap,
    required this.data,
  });
  final ValueChanged<int> onDelete;
  final ValueChanged<int> onTag;
  final ValueChanged<int> onQuote;
  final ValueChanged<String> onTap;

  final List<TemplateModelEntity> data;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => data.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(
      color: Globals.statesColor,
      cells: cellsMessage(index),
    );
  }

  List<DataCell> cellsMessage(int index) {
    return [
      DataCell(
        InkWell(
          onTap: () {
            onTap(data[index].domain);
          },
          child: Text(data[index].domain),
        ),
      ),
      DataCell(
        Text(data[index].tag),
      ),
      DataCell(
        onCollect(data[index].collectType),
      ),
      DataCell(
        Text(IDateUtils.format(DateTime.parse(data[index].createdAt)) ?? ""),
      ),
      DataCell(
        Text("${data[index].quote}"),
      ),
      DataCell(
        Row(
          children: [
            Transform.scale(
              scale: 0.8,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 10, 77, 30),
                  ),
                ),
                onPressed: () {
                  onTag(data[index].id);
                },
                child: const Text(
                  '修改标签',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Transform.scale(
              scale: 0.8,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 10, 77, 30),
                  ),
                ),
                onPressed: () {
                  onQuote(data[index].id);
                },
                child: const Text(
                  '修改引用数',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Transform.scale(
              scale: 0.8,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 248, 140, 133)),
                ),
                onPressed: () {
                  onDelete(data[index].id);
                },
                child: const Text(
                  '删除',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget onCollect(int index) {
    switch (index) {
      case 0:
        return const Text("移动端");
      case 1:
        return const Text("PC端");
      case 2:
        return const Text("自适应");
    }
    return const Text("-");
  }
}

class IShowDialog extends StatelessWidget {
  const IShowDialog({
    super.key,
    this.onPressed,
    this.child,
    this.title,
    required this.value,
  });
  final String? title;
  final VoidCallback? onPressed;
  final Widget? child;
  final UpdateScope value;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UpdateScope>.value(
      value: value,
      child: Consumer<UpdateScope>(builder: (_, scope, __) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Text(title ?? "警告"),
          titleTextStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          content: child ?? const Text("确定删除该条记录？"),
          actions: <Widget>[
            VariousStatelessButton(
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.white,
              textColor: Colors.black,
              title: "取消",
              padding: const EdgeInsets.symmetric(horizontal: 5),
            ),
            VariousStatelessButton(
              onPressed: onPressed,
              color: const Color.fromARGB(255, 33, 82, 243),
              textColor: Colors.white,
              title: "确定",
              padding: const EdgeInsets.symmetric(horizontal: 5),
            ),
          ],
        );
      }),
    );
  }
}

Widget addTagCell(TemplateBloc bloc) {
  return SizedBox(
    height: 70,
    width: 600,
    child: Column(
      children: [
        ITextListCell(
          title: "模板标签",
          width: 90,
          children: [
            ITextField(
              controller: bloc.tagController,
              width: double.infinity,
              maxLines: 1,
              height: 35,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget addQuoteCell(TemplateBloc bloc) {
  return SizedBox(
    height: 70,
    width: 600,
    child: Column(
      children: [
        ITextListCell(
          title: "使用次数",
          width: 90,
          children: [
            NumberInputWidget(
              controller: bloc.countController,
              defaultVal: bloc.sliderValue,
              subtractValueChanged: (value) => bloc.onSlider(value),
              inputFormatters: [NumberInputFormatter(isAllowDecimal: false)],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget addTemplateCell(TemplateBloc bloc) {
  return SizedBox(
    height: 400,
    width: 600,
    child: Column(
      children: [
        ChangeNotifierProvider<UpdateScope>.value(
          value: bloc.scope,
          child: Consumer<UpdateScope>(builder: (_, scope, __) {
            return ITextListCell(
              title: "终端类型",
              width: 90,
              children: [
                ...bloc.linksList.map(
                  (e) => IRadioFileList(
                    value: e.value,
                    title: e.title,
                    isRadio: true,
                    groupValue: bloc.groupValueOption,
                    onChanged: (value) => bloc.onRadio(value, e.type),
                  ),
                ),
              ],
            );
          }),
        ),
        ITextListCell(
          title: "模        板",
          width: 90,
          children: [
            ITextField(
              controller: bloc.domainController,
              width: double.infinity,
              maxLines: 13,
            ),
          ],
        ),
      ],
    ),
  );
}
