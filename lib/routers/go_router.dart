import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_seo_servers/view/seo.dart';
import 'package:provider/provider.dart';

class AppRouters {
  static GlobalKey<NavigatorState> seoNavKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> rootNavKey = GlobalKey<NavigatorState>();

  /// 用于路径路由(声明式路由)的常量, 路径不包含参数
  static const String homePath = '/'; // 根路由
  static const String editTemplatePath = '/edit_template';

  /// 用于 命名路由的常量
  static const String templateNamed = 'template';
  static const String editTemplateNamed = 'edit_template';

  static GoRouter router = GoRouter(
    navigatorKey: rootNavKey,
    initialLocation: homePath,
    // 默认路由, 不指定这一荐时，默认路由为 '/'
    routes: [
      ShellRoute(
        navigatorKey: seoNavKey,
        routes: [
          GoRoute(
            path: homePath,
            name: templateNamed,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: Provider<TemplateBloc>(
                  create: (_) => TemplateBloc(),
                  child: const TemplatePage(),
                ),
              );
            },
          ),
          GoRoute(
            path: editTemplatePath,
            name: editTemplateNamed,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: Provider<EditTemplateBloc>(
                  create: (_) => EditTemplateBloc(),
                  child: const EditTemplatePage(),
                ),
              );
            },
          ),
        ],
        builder: (context, state, child) {
          return Provider<SEOHomeBloc>(
            create: (_) => SEOHomeBloc(),
            child: SeoHomePage(
              state: state,
              child: child,
            ),
          );
        },
      ),
    ],
    errorBuilder: (context, GoRouterState state) {
      return const ErrorPage();
    },
  );
}

CustomTransitionPage customTransitionPage(
    {required GoRouterState state, required Widget child}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 150),
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
  );
}
