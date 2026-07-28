import 'package:darkoff/domain/entities/barter_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'barters_state.freezed.dart';

@freezed
class BartersState with _$BartersState {
  const factory BartersState.initial() = BartersInitial;
  const factory BartersState.loading() = BartersLoading;
  const factory BartersState.loaded(List<BarterEntity> barters) = BartersLoaded;
  const factory BartersState.error(String message) = BartersError;
}
