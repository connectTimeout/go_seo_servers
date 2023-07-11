import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

///
/// 公司：南京光速体育科技有限公司
/// 作者：小杨~~
/// 时间：2023/6/5
///

class IOverlayEntry extends OverlayEntry {
  final WidgetBuilder builders;

  IOverlayEntry({
    required this.builders,
  }) : super(builder: builders);

  @override
  void markNeedsBuild() {
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        super.markNeedsBuild();
      });
    } else {
      super.markNeedsBuild();
    }
  }
}
