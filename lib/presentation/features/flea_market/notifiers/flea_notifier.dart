import 'package:flea_contract/flea_contract.dart';
import 'package:darkoff/presentation/features/flea_market/mapper/flea_item_ui_mapper.dart';
import 'package:darkoff/presentation/features/flea_market/state/flea_state.dart';
import 'package:darkoff/service_locator/flea_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flea_notifier.g.dart';

@riverpod
class FleaNotifier extends _$FleaNotifier {
  late FleaRepository _repository;
  late FleaItemUiMapper _uiMapper;

  @override
  FleaState build() {
    _repository = getIt<FleaRepository>();
    _uiMapper = getIt<FleaItemUiMapper>();
    _load();
    return const FleaState.initial();
  }

  Future<void> _load() async {
    state = const FleaState.loading();
    try {
      final result = await _repository.getFleaItems();
      result.fold(
        (items) => state = FleaState.loaded(_uiMapper.fromEntities(items)),
        (error) => state = FleaState.error(error.toString()),
      );
    } catch (e) {
      state = FleaState.error(e.toString());
    }
  }

  Future<void> refresh() async => _load();
}
