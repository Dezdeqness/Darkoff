import 'package:boss_contract/boss_contract.dart';
import 'package:darkoff/presentation/features/bosses/model/boss_list_ui_model.dart';

class BossListUiMapper {
  List<BossListItemUiModel> toListModel(List<BossEntity> bosses) => bosses
      .map(
        (boss) => BossListItemUiModel(
          id: boss.id,
          name: boss.name,
          portraitUrl: boss.imagePortraitLink,
          healthLabel: (boss.healthMax ?? 0) > 0
              ? '${boss.healthMax} HP total'
              : null,
          mapLabels: _mapLabels(boss),
        ),
      )
      .toList();

  List<String> _mapLabels(BossEntity boss) =>
      boss.mapSpawns.map((s) => s.mapName).toSet().toList();
}
