import 'package:darkoff/domain/entities/hideout_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hideout_state.freezed.dart';

@freezed
class HideoutState with _$HideoutState {
  const factory HideoutState.initial() = HideoutInitial;
  const factory HideoutState.loading() = HideoutLoading;
  const factory HideoutState.empty() = HideoutEmpty;
  const factory HideoutState.loaded(List<HideoutStationEntity> stations) =
      HideoutLoaded;
  const factory HideoutState.error(String message) = HideoutError;
}
