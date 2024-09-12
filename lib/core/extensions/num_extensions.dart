extension CleanNumber on num {
  double _roundedValue(num value) {
    return (value * 4).roundToDouble() / 4;
  }

  String cleanNumber({int? decimal}) {
    if (decimal != null) return toStringAsFixed(decimal);

    final roundedNumber = _roundedValue(this);
    if (roundedNumber % 1.0 == 0.0) return roundedNumber.toStringAsFixed(0);
    if (roundedNumber % 0.5 == 0.0) return roundedNumber.toStringAsFixed(1);
    return roundedNumber.toStringAsFixed(2);
  }
}
