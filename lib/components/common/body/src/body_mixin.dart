import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_seo_servers/components/components.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///
/// 公司：南京光速体育科技有限公司
/// 作者：小杨~~
/// 时间：2023/6/5
///

String kBodyFunctionNullIndicator = '@5b64dbf5570c68647423a8ca361cd2e7';

mixin class BodyMixin<T> {
  final BodyController<T> controller = BodyController<T>();

  /// 必须要给Body赋值vsync才能使用
  late BuildContext context;

  /// 必须要给Body赋值vsync才能使用
  void initState() {}

  /// 必须要给Body赋值vsync才能使用
  void dispose() {}

  bool _loadding = false;

  RefreshController? _refreshController;
  RefreshController get refreshController {
    _refreshController ??= RefreshController();
    return _refreshController!;
  }

  /// 初始化数据
  Future<T>? onInit() {
    return Future<String>.value(kBodyFunctionNullIndicator) as Future<T>;
  }

  /// 加载数据
  Future<T>? onLoading() {
    return Future<String>.value(kBodyFunctionNullIndicator) as Future<T>;
  }

  Future<void> refresh({
    bool init = true,
    String? message,
    Duration duration = const Duration(milliseconds: 200),
  }) async {
    if (_loadding) return;
    _loadding = !_loadding;
    try {
      _refreshController?.refreshCompleted(resetFooterState: true);
      if (init) {
        UX.show(message);
        await onInit();
        UX.hidden();
      }
      if (!init) {
        _refreshController?.requestRefresh(duration: duration);
      }
    } catch (e) {
      UX.hidden();
      UX.toast(e.toString());
    }
    _loadding = !_loadding;
  }
}
