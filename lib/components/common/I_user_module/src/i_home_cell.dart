import 'package:flutter/material.dart';
import 'package:go_seo_servers/components/components.dart';

class IHomeCell extends StatefulWidget {
  const IHomeCell({
    super.key,
    required this.child,
    required this.model,
    required this.taberChild,
  });

  final Widget child;
  final Widget taberChild;

  final List<ITabBarModel> model;

  @override
  State<IHomeCell> createState() => _IHomeCellState();
}

class _IHomeCellState extends State<IHomeCell> {
  int? selectIndex;
  String? namePath;
  bool onHover = false;
  void onIndex(int index) async {
    var sp = await SpUtil.getInstance();
    sp?.putInt("index", index);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        const Positioned.fill(
          child: ColoredBox(
            color: Colors.black,
          ),
        ),
        BorderCell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BorderCell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 45,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.amberAccent, width: 0.5)),
                        child: const Text("模板库",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              BorderCell(
                top: BorderSide.none,
                bottom: BorderSide.none,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SizedBox(
                    height: size.height - 84,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Expanded(child: widget.taberChild),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: widget.child,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ITabBarModel {
  final IconData? icon;
  final String? title;
  final String? namePath;
  final Map<String, dynamic>? queryParameters;
  ITabBarModel(
    this.namePath, {
    this.icon,
    this.title,
    this.queryParameters,
  });
}

///边框线
BorderSide borderSide = const BorderSide(color: Colors.yellow, width: 3.0);

class BorderCell extends StatelessWidget {
  const BorderCell({
    super.key,
    required this.child,
    this.top,
    this.right,
    this.bottom,
    this.left,
  });
  final Widget child;
  final BorderSide? top;
  final BorderSide? right;
  final BorderSide? bottom;
  final BorderSide? left;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: top ?? borderSide,
          right: right ?? borderSide,
          bottom: bottom ?? borderSide,
          left: left ?? borderSide,
        ),
      ),
      child: child,
    );
  }
}
