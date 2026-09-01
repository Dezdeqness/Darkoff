import 'package:ammo_contract/ammo_contract.dart';
import 'package:darkoff/presentation/features/ammo/mapper/ammo_chart_ui_mapper.dart';
import 'package:darkoff/presentation/features/ammo/state/ammo_chart_state.dart';
import 'package:darkoff/service_locator/ammo_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ammo_chart_notifier.g.dart';

@riverpod
class AmmoChartNotifier extends _$AmmoChartNotifier {
  late AmmoRepository _repository;
  late AmmoChartUiMapper _mapper;

  @override
  AmmoChartState build({
    required String caliber,
    required String currentItemId,
  }) {
    _repository = getIt<AmmoRepository>();
    _mapper = getIt<AmmoChartUiMapper>();
    _load();
    return const AmmoChartState.loading();
  }

  Future<void> _load() async {
    state = const AmmoChartState.loading();
    try {
      final result = await _repository.getAmmo();
      result.fold(
        (ammo) {
          final chart = _mapper.fromEntities(
            ammo,
            caliber: caliber,
            currentItemId: currentItemId,
          );
          state = AmmoChartState.loaded(chart);
        },
        (error) => state = AmmoChartState.error(error.toString()),
      );
    } catch (e) {
      state = AmmoChartState.error(e.toString());
    }
  }
}
