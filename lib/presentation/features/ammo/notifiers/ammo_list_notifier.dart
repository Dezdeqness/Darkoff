import 'package:darkoff/domain/entities/ammo_entity.dart';
import 'package:darkoff/presentation/features/ammo/mapper/ammo_list_ui_mapper.dart';
import 'package:darkoff/presentation/features/ammo/model/ammo_list_ui_model.dart';
import 'package:darkoff/presentation/features/ammo/notifiers/ammo_notifier.dart';
import 'package:darkoff/presentation/features/ammo/state/ammo_list_state.dart';
import 'package:darkoff/presentation/features/ammo/state/ammo_state.dart';
import 'package:darkoff/service_locator/ammo_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ammo_list_notifier.g.dart';

@riverpod
class AmmoListNotifier extends _$AmmoListNotifier {
  late AmmoListUiMapper _mapper;

  String? _selectedCaliber;
  String _search = '';
  bool _sortByPen = true;

  @override
  AmmoListState build() {
    _mapper = getIt<AmmoListUiMapper>();

    final state = ref.watch(ammoProvider);

    return switch (state) {
      AmmoLoaded(:final ammo) => AmmoListState.loaded(_map(ammo)),
      AmmoError(:final message) => AmmoListState.error(message),
      _ => const AmmoListState.loading(),
    };
  }

  void selectCaliber(String? caliber) {
    _selectedCaliber = caliber;
    _recompute();
  }

  void setSearch(String search) {
    _search = search;
    _recompute();
  }

  void toggleSort() {
    _sortByPen = !_sortByPen;
    _recompute();
  }

  Future<void> refresh() => ref.read(ammoProvider.notifier).refresh();

  void _recompute() {
    final raw = ref.read(ammoProvider);
    if (raw is AmmoLoaded) {
      state = AmmoListState.loaded(_map(raw.ammo));
    }
  }

  AmmoListUiModel _map(List<AmmoEntity> ammo) => _mapper.build(
    ammo,
    selectedCaliber: _selectedCaliber,
    search: _search,
    sortByPen: _sortByPen,
  );
}
