
double? lerpDouble(double? a, double? b, double t) {
  if (a == null && b == null) return null;
  a ??= b;
  b ??= a;
  return a! + (b! - a) * t;
}
