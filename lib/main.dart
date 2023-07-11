import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_seo_servers/components/components.dart';
import 'package:go_seo_servers/consts/consts.dart';
import 'package:provider/provider.dart';

import 'routers/routers.dart';
import 'server/cors.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  onServer();
  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Globals.oceanBlue,
          centerTitle: false,
          foregroundColor: Colors.white,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
          ),
          actionsIconTheme: const IconThemeData(color: Colors.white),
        ),
      ),
      onGenerateTitle: (context) {
        return '你知道';
      },
      routerConfig: AppRouters.router,
      builder: IToast.init(),
    );
  }
}
