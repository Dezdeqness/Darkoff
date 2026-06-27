import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatefulWidget {
  const AnimatedProgressBar({
    super.key,
    this.value,
    this.width = 240,
    this.height = 3,
  });

  final double? value;
  final double width;
  final double height;

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _syncController();
  }

  @override
  void didUpdateWidget(AnimatedProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) _syncController();
  }

  void _syncController() {
    if (widget.value == null) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.height),
        child: ColoredBox(
          color: colors.surfaceHigh,
          child: widget.value == null
              ? _buildIndeterminate(context)
              : _buildDeterminate(context),
        ),
      ),
    );
  }

  Widget _buildDeterminate(BuildContext context) {
    final colors = context.colorTheme;

    final target = widget.value!.clamp(0.0, 1.0);
    return Align(
      alignment: Alignment.centerLeft,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: target),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
        builder: (context, t, _) => FractionallySizedBox(
          widthFactor: t,
          child: Container(color: colors.gold),
        ),
      ),
    );
  }

  Widget _buildIndeterminate(BuildContext context) {
    final colors = context.colorTheme;

    const segmentFraction = 0.4;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = Curves.easeInOut.transform(_controller.value);
        final travel = widget.width * (1 + segmentFraction);
        final left = travel * t - widget.width * segmentFraction;
        return Stack(
          children: [
            Positioned(
              left: left,
              top: 0,
              bottom: 0,
              width: widget.width * segmentFraction,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colors.gold.withValues(alpha: 0),
                      colors.gold,
                      colors.gold.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
