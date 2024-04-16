import 'package:flutter/cupertino.dart';

class DimmedBottomSlidePopup extends StatefulWidget {
  Widget child;
  bool visible;
  Duration duration;
  Curve curve;
  Color color;
  void Function()? onCancel;

  DimmedBottomSlidePopup(
      {required this.child,
      this.visible = true,
      this.duration = const Duration(milliseconds: 300),
      this.curve = Curves.fastEaseInToSlowEaseOut,
      this.color = const Color(0x4C000000),
      this.onCancel,
      super.key});

  @override
  State<DimmedBottomSlidePopup> createState() => _DimmedBottomSlidePopup();
}

class _DimmedBottomSlidePopup extends State<DimmedBottomSlidePopup>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slideAnimation;
  late Animation<double> fadeAnimation;
  bool visible = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    slideAnimation = Tween(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: widget.curve,
      ),
    );

    fadeAnimation = CurvedAnimation(
      parent: controller,
      curve: widget.curve,
    );

    _updateVisible();
    setState(() => visible = widget.visible);
  }

  @override
  void didUpdateWidget(covariant DimmedBottomSlidePopup oldWidget) {
    _updateVisible();
    super.didUpdateWidget(oldWidget);
  }

  _updateVisible() {
    setState(() => visible = true);
    if (widget.visible) {
      controller.forward();
    } else {
      controller.reverse().whenComplete(() => setState(() => visible = false));
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox();

    return Stack(
      children: [
        GestureDetector(
          onTap: () => widget.onCancel?.call(),
          child: FadeTransition(
            opacity: fadeAnimation,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: widget.color,
            ),
          ),
        ),
        SlideTransition(
          position: slideAnimation,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.black.withOpacity(0.2),
                    offset: const Offset(0, -1),
                    blurRadius: 8,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: widget.child,
            ),
          ),
        ),
      ],
    );
  }
}
