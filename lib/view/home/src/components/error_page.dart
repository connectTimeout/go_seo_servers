import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_seo_servers/routers/routers.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('error page')),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              context.go(AppRouters.homePath);
            },
            child: const Text('go home')),
      ),
    );
  }
}
