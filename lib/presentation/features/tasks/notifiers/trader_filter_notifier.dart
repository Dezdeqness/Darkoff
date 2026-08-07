import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/presentation/features/tasks/model/trader_filter_ui_model.dart';
import 'package:darkoff/presentation/features/tasks/state/trader_filter_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'trader_filter_notifier.g.dart';

@riverpod
class TraderFilterNotifier extends _$TraderFilterNotifier {
  @override
  TraderFilterState build() {
    // TODO(any): Make remote related
    return TraderFilterState(
      traders: [
        TraderFilterUiModel(label: tr.common.filter.all),
        const TraderFilterUiModel(label: 'Prapor', normalizedName: 'prapor'),
        const TraderFilterUiModel(label: 'Therapist', normalizedName: 'therapist'),
        const TraderFilterUiModel(label: 'Skier', normalizedName: 'skier'),
        const TraderFilterUiModel(label: 'Peacekeeper', normalizedName: 'peacekeeper'),
        const TraderFilterUiModel(label: 'Mechanic', normalizedName: 'mechanic'),
        const TraderFilterUiModel(label: 'Ragman', normalizedName: 'ragman'),
        const TraderFilterUiModel(label: 'Jaeger', normalizedName: 'jaeger'),
      ],
    );
  }

  void selectTrader(int index) {
    state = state.copyWith(selectedIndex: index);
  }
}
