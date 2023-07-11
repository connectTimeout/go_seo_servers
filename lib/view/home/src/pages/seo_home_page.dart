import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_seo_servers/components/components.dart';
import 'package:go_seo_servers/routers/routers.dart';
import 'package:go_seo_servers/view/seo.dart';
import 'package:provider/provider.dart';

class SeoHomePage extends StatelessWidget {
  const SeoHomePage({
    super.key,
    required this.state,
    required this.child,
  });

  final GoRouterState state;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<SEOHomeBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Body(
        onInit: bloc.onInit,
        builder: (context, data) {
          return IHomeCell(
            model: bloc.model,
            taberChild: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: bloc.model.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var model = bloc.model[index];
                return ITextButton(
                    padding: const EdgeInsets.all(5),
                    title: model.title ?? "",
                    icon: model.icon ?? Icons.home_sharp,
                    isIcon: true,
                    isSelect: index == bloc.selectIndex,
                    onPressed: () {
                      bloc.onTaber(index, model.namePath);
                      context.goNamed(
                        model.namePath ?? AppRouters.templateNamed,
                      );
                    });
              },
            ),
            child: child,
          );
        },
      ),
    );
  }
}
