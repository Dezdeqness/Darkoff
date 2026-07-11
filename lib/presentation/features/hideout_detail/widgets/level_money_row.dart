import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/presentation/features/hideout_detail/model/hideout_detail_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LevelMoneyRow extends StatefulWidget {
  const LevelMoneyRow({
    super.key,
    required this.row,
    required this.readOnly,
    required this.onChanged,
  });

  final MoneyReqRowUiModel row;
  final bool readOnly;
  final ValueChanged<int> onChanged;

  @override
  State<LevelMoneyRow> createState() => _LevelMoneyRowState();
}

class _LevelMoneyRowState extends State<LevelMoneyRow> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.row.owned == 0 ? '' : '${widget.row.owned}',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final row = widget.row;

    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 8),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: colors.goldSubtle,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                row.symbol,
                style: typo.labelLarge.copyWith(color: colors.gold),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.name,
                  style: typo.labelMedium.copyWith(color: colors.textPrimary),
                ),
                Text(
                  row.subtitle,
                  style: typo.paragraphSmall.copyWith(
                    color: row.met ? colors.profit : colors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          if (widget.readOnly)
            Text(
              row.requiredText,
              style: typo.labelMedium.copyWith(
                color: colors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: colors.background,
                border:
                    Border.all(color: row.met ? colors.profit : colors.gold),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 80,
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textAlign: TextAlign.right,
                      style: typo.labelMedium.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        hintText: '0',
                        hintStyle: typo.labelMedium
                            .copyWith(color: colors.textTertiary),
                      ),
                      onChanged: (v) => widget.onChanged(int.tryParse(v) ?? 0),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    row.symbol,
                    style: typo.paragraphSmall.copyWith(color: colors.gold),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
