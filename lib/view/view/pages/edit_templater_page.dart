import 'package:flutter/material.dart';
import 'package:go_seo_servers/components/components.dart';
import 'package:go_seo_servers/view/seo.dart';
import 'package:provider/provider.dart';

class EditTemplatePage extends StatelessWidget {
  const EditTemplatePage({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<EditTemplateBloc>(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 10, bottom: 5, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          onRefreshDomain(bloc: bloc),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: ITextField(
              controller: bloc.editController,
              width: double.infinity,
              maxLines: 20,
              hintText: "请输入",
            ),
          ),
          VariousStatelessButton(
            onPressed: () => bloc.onSubmit(),
            color: Colors.blue,
            textColor: Colors.white,
            title: "提交",
          ),
        ],
      ),
    );
  }

  Widget onRefreshDomain({
    required EditTemplateBloc bloc,
  }) {
    return ChangeNotifierProvider<PagesScope>.value(
      value: bloc.pageScope,
      child: Consumer<PagesScope>(builder: (_, scope, __) {
        return MenuAnchor(
          builder: (context, controller, child) {
            return Row(
              children: [
                ITextField(
                  controller: bloc.searchController,
                  width: 400,
                  height: 35,
                  maxLines: 1,
                  hintText: "请输入要编辑的模板页面",
                  onSubmitted: (e) => bloc.onSearch(controller),
                ),
                const SizedBox(width: 20),
                VariousStatelessButton(
                  onPressed: () => bloc.onSearch(controller),
                  color: Colors.blue,
                  textColor: Colors.white,
                  title: "查询",
                ),
              ],
            );
          },
          menuChildren: [
            bloc.pagesLsit?.isNotEmpty ?? false
                ? SizedBox(
                    height: 350,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: bloc.pagesLsit?.map(
                              (e) {
                                String name = "$e";
                                int textMax = name.length;
                                return MenuItemButton(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${e?.substring(30, textMax) ?? "-"}",
                                    ),
                                  ),
                                  onPressed: () => bloc.onMenu("$e"),
                                );
                              },
                            ).toList() ??
                            [],
                      ),
                    ),
                  )
                : const SizedBox(
                    width: 400,
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        "没有查询到您想要的结果",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ],
        );
      }),
    );
  }
}
