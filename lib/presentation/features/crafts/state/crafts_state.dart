import 'package:darkoff/domain/entities/craft_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'crafts_state.freezed.dart';

@freezed
class CraftsState with _$CraftsState {
  const factory CraftsState.initial() = CraftsInitial;
  const factory CraftsState.loading() = CraftsLoading;
  const factory CraftsState.loaded(List<CraftEntity> crafts) = CraftsLoaded;
  const factory CraftsState.error(String message) = CraftsError;
}
