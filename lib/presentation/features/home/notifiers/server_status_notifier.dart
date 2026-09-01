import 'package:server_status_contract/server_status_contract.dart';
import 'package:darkoff/presentation/features/home/mapper/server_status_ui_mapper.dart';
import 'package:darkoff/presentation/features/home/state/server_status_state.dart';
import 'package:darkoff/service_locator/service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_status_notifier.g.dart';

@riverpod
class ServerStatusNotifier extends _$ServerStatusNotifier {
  late ServerStatusRepository _repository;
  late ServerStatusUiMapper _mapper;

  @override
  ServerStatusState build() {
    _repository = getIt<ServerStatusRepository>();
    _mapper = getIt<ServerStatusUiMapper>();
    loadStatus();
    return const ServerStatusState.initial();
  }

  Future<void> loadStatus() async {
    state = const ServerStatusState.loading();
    try {
      final result = await _repository.getStatus();
      result.fold(
        (status) =>
            state = ServerStatusState.loaded(_mapper.fromEntity(status)),
        (error) => state = ServerStatusState.error(error.toString()),
      );
    } catch (e) {
      state = ServerStatusState.error(e.toString());
    }
  }

  Future<void> refresh() => loadStatus();
}
