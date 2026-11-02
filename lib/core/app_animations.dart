import 'package:flutter/material.dart';

class AppAnimations {
  AppAnimations._();

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration splash = Duration(milliseconds: 900);
  static const Duration onboarding = Duration(milliseconds: 1100);
  static const Duration home = Duration(milliseconds: 900);
  static const Duration badgeFloat = Duration(milliseconds: 2400);
  static const Duration staggerStep = Duration(milliseconds: 70);

  static const Curve easeOutCubic = Curves.easeOutCubic;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve easeOutBack = Curves.easeOutBack;
}

class PressableScale extends StatefulWidget {
  final Widget child;
  final double pressedScale;

  const PressableScale({
    super.key,
    required this.child,
    this.pressedScale = 0.96,
  });

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _setPressed(true),
      onPointerUp: (_) => _setPressed(false),
      onPointerCancel: (_) => _setPressed(false),
      child: AnimatedScale(
        scale: _pressed ? widget.pressedScale : 1,
        duration: AppAnimations.fast,
        curve: AppAnimations.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}

class FadeSlideIn extends StatefulWidget {
  final Animation<double> parent;
  final double begin;
  final double end;
  final Offset offset;
  final Widget child;

  const FadeSlideIn({
    super.key,
    required this.parent,
    required this.child,
    this.begin = 0,
    this.end = 1,
    this.offset = const Offset(0, 0.12),
  });

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn> {
  late CurvedAnimation _curved;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  @override
  void didUpdateWidget(FadeSlideIn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.parent != widget.parent ||
        oldWidget.begin != widget.begin ||
        oldWidget.end != widget.end ||
        oldWidget.offset != widget.offset) {
      _curved.dispose();
      _setup();
    }
  }

  void _setup() {
    _curved = CurvedAnimation(
      parent: widget.parent,
      curve: Interval(
        widget.begin,
        widget.end,
        curve: AppAnimations.easeOutCubic,
      ),
    );
    _slide = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(_curved);
  }

  @override
  void dispose() {
    _curved.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _curved,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}

class StaggeredFadeSlide extends StatefulWidget {
  final int index;
  final Widget child;
  final Offset offset;

  const StaggeredFadeSlide({
    super.key,
    required this.index,
    required this.child,
    this.offset = const Offset(0, 0.08),
  });

  @override
  State<StaggeredFadeSlide> createState() => _StaggeredFadeSlideState();
}

class _StaggeredFadeSlideState extends State<StaggeredFadeSlide>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppAnimations.slow,
    );
    final curved = CurvedAnimation(
      parent: _controller,
      curve: AppAnimations.easeOutCubic,
    );
    _opacity = curved;
    _slide = Tween<Offset>(begin: widget.offset, end: Offset.zero).animate(curved);

    final delay = AppAnimations.staggerStep * widget.index;
    Future.delayed(delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}
