import 'package:darkoff/presentation/features/keys/model/keys_list_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'keys_list_state.freezed.dart';

@freezed
class KeysListState with _$KeysListState {
  const factory KeysListState.loading() = KeysListLoading;
  const factory KeysListState.loaded(KeysListUiModel keys) = KeysListLoaded;
  const factory KeysListState.error(String message) = KeysListError;
}
