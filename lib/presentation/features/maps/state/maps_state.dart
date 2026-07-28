import 'package:darkoff/presentation/features/maps/model/map_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'maps_state.freezed.dart';

@freezed
class MapsState with _$MapsState {
  const factory MapsState.initial() = MapsInitial;
  const factory MapsState.loading() = MapsLoading;
  const factory MapsState.empty() = MapsEmpty;
  const factory MapsState.loaded(List<MapUiModel> maps) = MapsLoaded;
  const factory MapsState.error(String message) = MapsError;
}
