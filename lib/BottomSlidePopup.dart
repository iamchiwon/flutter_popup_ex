import 'package:flutter/cupertino.dart';

class BottomSlidePopup extends StatefulWidget {
  Widget child;
  bool visible;
  Duration duration;
  Curve curve;

  BottomSlidePopup(
      {required this.child,
      this.visible = true,
      this.duration = const Duration(milliseconds: 300),
      this.curve = Curves.fastEaseInToSlowEaseOut,
      super.key});

  @override
  State<BottomSlidePopup> createState() => _BottomSlidePopupState();
}

class _BottomSlidePopupState extends State<BottomSlidePopup>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slideAnimation;

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

    _updateVisible();
  }

  @override
  void didUpdateWidget(covariant BottomSlidePopup oldWidget) {
    _updateVisible();
    super.didUpdateWidget(oldWidget);
  }

  _updateVisible() {
    if (widget.visible) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
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
    );
  }
}
