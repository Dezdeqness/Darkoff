import 'package:darkoff/core/widgets/section_label.dart';
import 'package:flutter/material.dart';

class HomeSection extends StatelessWidget {
  HomeSection({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  final _switchDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel(title),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AnimatedSwitcher(duration: _switchDuration, child: child),
          ),
        ],
      ),
    );
  }
}
