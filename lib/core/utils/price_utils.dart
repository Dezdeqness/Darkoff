String formatPrice(int price) {
  final str = price.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < str.length; i++) {
    if (i > 0 && (str.length - i) % 3 == 0) buffer.write(' ');
    buffer.write(str[i]);
  }
  return buffer.toString();
}

String formatCompactPrice(int price) {
  if (price >= 1000000) {
    final m = price / 1000000;
    return '${m.toStringAsFixed(m % 1 == 0 ? 0 : 1)}M';
  }
  if (price >= 1000) {
    return '${(price / 1000).round()}K';
  }
  return price.toString();
}

String currencySymbol(String currency) {
  return switch (currency) {
    'RUB' => '\u20BD',
    'USD' => '\$',
    'EUR' => '\u20AC',
    _ => currency,
  };
}
