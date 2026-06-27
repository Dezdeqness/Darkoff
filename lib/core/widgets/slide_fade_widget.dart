import 'package:flutter/material.dart';

enum SlideDirection {
  left,
  right,
  top,
  bottom,
  none,
}

class SlideFadeWidget extends StatefulWidget {
  const SlideFadeWidget({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 750),
    this.offset = 90,
    this.direction = SlideDirection.top,
    this.curve = Curves.easeOutCubic,
    this.onCompleted,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offset;
  final SlideDirection direction;
  final Curve curve;
  final VoidCallback? onCompleted;

  @override
  State<SlideFadeWidget> createState() => _SlideFadeState();
}

class _SlideFadeState extends State<SlideFadeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _curve;

  Offset _calculateOffset() {
    final value = widget.offset * (1 - _curve.value);

    return switch (widget.direction) {
      SlideDirection.left => Offset(-value, 0),
      SlideDirection.right => Offset(value, 0),
      SlideDirection.top => Offset(0, -value),
      SlideDirection.bottom => Offset(0, value),
      SlideDirection.none => Offset.zero,
    };
  }

  @override
  void didUpdateWidget(covariant SlideFadeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _curve = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onCompleted?.call();
      }
    });


    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curve,
      builder: (context, child) {
        return Opacity(
          opacity: _curve.value,
          child: widget.direction == SlideDirection.none
              ? child
              : Transform.translate(
            offset: _calculateOffset(),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
