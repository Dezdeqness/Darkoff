import 'package:flutter/widgets.dart';

abstract class HomeKeys {
  static const Key marketEmpty = ValueKey('market_empty');
  static const Key marketError = ValueKey('market_error');
  static const Key marketLoading = ValueKey('market_loading');
  static const Key marketLoaded = ValueKey('market_loaded');
  static const Key priceChangesEmpty = ValueKey('price_empty');
  static const Key priceChangesError = ValueKey('price_error');
  static const Key priceChangesLoading = ValueKey('price_loading');
  static const Key priceChangesLoaded = ValueKey('price_loaded');
}
