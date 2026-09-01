import 'package:keys_contract/keys_contract.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'keys_state.freezed.dart';

@freezed
class KeysState with _$KeysState {
  const factory KeysState.initial() = KeysInitial;
  const factory KeysState.loading() = KeysLoading;
  const factory KeysState.loaded(List<KeyEntity> keys) = KeysLoaded;
  const factory KeysState.error(String message) = KeysError;
}
