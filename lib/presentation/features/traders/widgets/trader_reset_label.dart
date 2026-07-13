import 'dart:async';

import 'package:flutter/material.dart';

const _tick = Duration(seconds: 60);

String traderResetLabel(String? resetTime) {
  if (resetTime == null) return '—';

  final DateTime resetAt;
  try {
    resetAt = DateTime.parse(resetTime).toLocal();
  } catch (_) {
    return '—';
  }

  final now = DateTime.now();
  final remaining = resetAt.difference(now);

  if (remaining.isNegative) {
    return 'Updated ${_formatElapsed(now.difference(resetAt))} ago';
  }
  if (remaining.inMinutes <= 0) return 'Coming soon';

  final h = remaining.inHours;
  final m = remaining.inMinutes % 60;
  return 'Resets in '
      '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
}

String _formatElapsed(Duration d) {
  final h = d.inHours;
  final m = d.inMinutes % 60;
  if (h > 0) return '${h}h ${m}m';
  if (m > 0) return '${m}m';
  return 'moments';
}

class TraderResetLabel extends StatefulWidget {
  const TraderResetLabel({super.key, required this.resetTime, this.style});

  final String? resetTime;
  final TextStyle? style;

  @override
  State<TraderResetLabel> createState() => _TraderResetLabelState();
}

class _TraderResetLabelState extends State<TraderResetLabel> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(_tick, (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      traderResetLabel(widget.resetTime),
      style: widget.style,
    );
  }
}
