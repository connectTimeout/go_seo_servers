import 'package:flutter/material.dart';

///
/// 公司：南京光速体育科技有限公司
/// 作者：小杨~~
/// @description: 异常页面
/// 时间：2023/6/5
///

class FadeTransitionView extends StatefulWidget {
  const FadeTransitionView({super.key, required this.child, this.speed = 500});
  final Widget child;

  final int speed;

  @override
  FadeTransitionViewState createState() => FadeTransitionViewState();
}

class FadeTransitionViewState extends State<FadeTransitionView>
    with TickerProviderStateMixin {
  late AnimationController _animationContainer;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _animationContainer = AnimationController(
      duration: Duration(milliseconds: widget.speed),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _animationContainer, curve: Curves.easeIn);
    _animationContainer.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _animationContainer.dispose();
    super.dispose();
  }
}
