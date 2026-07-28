import 'package:darkoff/presentation/features/maps/model/map_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_detail_state.freezed.dart';

@freezed
class MapDetailState with _$MapDetailState {
  const factory MapDetailState.loading() = MapDetailLoading;
  const factory MapDetailState.loaded(MapUiModel map) = MapDetailLoaded;
  const factory MapDetailState.error(String message) = MapDetailError;
}
