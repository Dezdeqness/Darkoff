import 'package:keys_contract/keys_contract.dart';
import 'package:darkoff/presentation/features/keys/mapper/keys_list_ui_mapper.dart';
import 'package:darkoff/presentation/features/keys/model/keys_list_ui_model.dart';
import 'package:darkoff/presentation/features/keys/notifiers/keys_notifier.dart';
import 'package:darkoff/presentation/features/keys/state/keys_list_state.dart';
import 'package:darkoff/presentation/features/keys/state/keys_state.dart';
import 'package:darkoff/service_locator/keys_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'keys_list_notifier.g.dart';

@riverpod
class KeysListNotifier extends _$KeysListNotifier {
  late KeysListUiMapper _mapper;

  String _search = '';
  KeySort _sort = KeySort.name;

  @override
  KeysListState build() {
    _mapper = getIt<KeysListUiMapper>();

    final state = ref.watch(keysProvider);

    return switch (state) {
      KeysLoaded(:final keys) => KeysListState.loaded(_map(keys)),
      KeysError(:final message) => KeysListState.error(message),
      _ => const KeysListState.loading(),
    };
  }

  void setSearch(String search) {
    _search = search;
    _recompute();
  }

  void setSort(KeySort sort) {
    _sort = sort;
    _recompute();
  }

  Future<void> refresh() => ref.read(keysProvider.notifier).refresh();

  void _recompute() {
    final raw = ref.read(keysProvider);
    if (raw is KeysLoaded) {
      state = KeysListState.loaded(_map(raw.keys));
    }
  }

  KeysListUiModel _map(List<KeyEntity> keys) =>
      _mapper.build(keys, search: _search, sort: _sort);
}
