import 'package:darkoff/domain/entities/trader_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'traders_state.freezed.dart';

@freezed
class TradersState with _$TradersState {
  const factory TradersState.initial() = TradersInitial;
  const factory TradersState.loading() = TradersLoading;
  const factory TradersState.loaded(List<TraderEntity> traders) = TradersLoaded;
  const factory TradersState.error(String message) = TradersError;
}
