import 'package:darkoff/presentation/features/tasks/model/trader_filter_ui_model.dart';
import 'package:darkoff/presentation/features/tasks/state/trader_filter_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'trader_filter_notifier.g.dart';

@riverpod
class TraderFilterNotifier extends _$TraderFilterNotifier {
  @override
  TraderFilterState build() {
    // TODO(any): Make remote related
    return const TraderFilterState(
      traders: [
        TraderFilterUiModel(label: 'All'),
        TraderFilterUiModel(label: 'Prapor', normalizedName: 'prapor'),
        TraderFilterUiModel(label: 'Therapist', normalizedName: 'therapist'),
        TraderFilterUiModel(label: 'Skier', normalizedName: 'skier'),
        TraderFilterUiModel(label: 'Peacekeeper', normalizedName: 'peacekeeper'),
        TraderFilterUiModel(label: 'Mechanic', normalizedName: 'mechanic'),
        TraderFilterUiModel(label: 'Ragman', normalizedName: 'ragman'),
        TraderFilterUiModel(label: 'Jaeger', normalizedName: 'jaeger'),
      ],
    );
  }

  void selectTrader(int index) {
    state = state.copyWith(selectedIndex: index);
  }
}
