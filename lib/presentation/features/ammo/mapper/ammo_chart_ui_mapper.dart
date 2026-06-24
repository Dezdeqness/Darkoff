import 'dart:ui';

import 'package:darkoff/domain/entities/ammo_entity.dart';
import 'package:darkoff/presentation/features/ammo/model/ammo_chart_ui_model.dart';

class AmmoChartUiMapper {
  AmmoChartUiModel fromEntities(
    List<AmmoEntity> ammo, {
    required String caliber,
    required String currentItemId,
  }) {
    final sameCaliber = ammo.where((a) => a.caliber == caliber).toList()
      ..sort((a, b) => b.penetrationPower.compareTo(a.penetrationPower));

    final rows = sameCaliber
        .map((a) => _rowFromEntity(a, currentItemId: currentItemId))
        .toList();

    return AmmoChartUiModel(rows: rows);
  }

  AmmoChartRowUiModel _rowFromEntity(
    AmmoEntity ammo, {
    required String currentItemId,
  }) {
    return AmmoChartRowUiModel(
      name: ammo.shortName,
      damage: '${ammo.damage}',
      penetration: '${ammo.penetrationPower}',
      penColor: _penColor(ammo.penetrationPower),
      isTracer: ammo.tracer,
      highlighted: ammo.id == currentItemId,
    );
  }

  // 6-tier penetration palette: weak (red) → strong (green)
  Color _penColor(int penetration) {
    if (penetration >= 50) return const Color(0xFF4A7C59);
    if (penetration >= 40) return const Color(0xFF8A9C5A);
    if (penetration >= 30) return const Color(0xFFC4A962);
    if (penetration >= 20) return const Color(0xFFB58A3C);
    if (penetration >= 10) return const Color(0xFF9C5E3C);
    return const Color(0xFF7C4A4A);
  }
}
