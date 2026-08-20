const List<String> supportedUnits = [
  'meters',
  'kilometers',
  'grams',
  'kilograms',
  'feet',
  'miles',
  'pounds (lbs)',
  'ounces',
];

const Map<String, double> _lengthToMeters = {
  'meters': 1,
  'kilometers': 1000,
  'feet': 0.3048,
  'miles': 1609.344,
};

const Map<String, double> _massToGrams = {
  'grams': 1,
  'kilograms': 1000,
  'pounds (lbs)': 453.59237,
  'ounces': 28.349523125,
};

double? convertValue(double value, String from, String to) {
  final lengthResult = _convertWithin(value, from, to, _lengthToMeters);
  if (lengthResult != null) {
    return lengthResult;
  }

  return _convertWithin(value, from, to, _massToGrams);
}

double? _convertWithin(
  double value,
  String from,
  String to,
  Map<String, double> factors,
) {
  final fromFactor = factors[from];
  final toFactor = factors[to];

  if (fromFactor == null || toFactor == null) {
    return null;
  }

  return value * fromFactor / toFactor;
}
