import 'dart:async';

import 'package:darkoff/core/localization/strings.g.dart';
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
    return tr.traders.reset.updatedAgo(
      elapsed: _formatElapsed(now.difference(resetAt)),
    );
  }
  if (remaining.inMinutes <= 0) return tr.traders.reset.comingSoon;

  final h = remaining.inHours;
  final m = remaining.inMinutes % 60;
  return '${tr.traders.reset.after}'
      '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
}

String _formatElapsed(Duration d) {
  final h = d.inHours;
  final m = d.inMinutes % 60;
  if (h > 0) return '${h}h ${m}m';
  if (m > 0) return '${m}m';
  return tr.traders.time.moments;
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
