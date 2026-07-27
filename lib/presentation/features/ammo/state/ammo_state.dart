import 'package:darkoff/domain/entities/ammo_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ammo_state.freezed.dart';

@freezed
class AmmoState with _$AmmoState {
  const factory AmmoState.initial() = AmmoInitial;
  const factory AmmoState.loading() = AmmoLoading;
  const factory AmmoState.loaded(List<AmmoEntity> ammo) = AmmoLoaded;
  const factory AmmoState.error(String message) = AmmoError;
}
