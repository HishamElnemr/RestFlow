double parseDouble(dynamic value) {
  if (value is num) {
    return value.toDouble();
  }
  final text = value?.toString();
  if (text == null || text.isEmpty) {
    return 0.0;
  }
  return double.tryParse(text) ?? 0.0;
}

DateTime? parseDateTime(dynamic value) {
  if (value == null) {
    return null;
  }
  if (value is DateTime) {
    return value;
  }
  final text = value.toString();
  if (text.isEmpty) {
    return null;
  }
  return DateTime.parse(text);
}
