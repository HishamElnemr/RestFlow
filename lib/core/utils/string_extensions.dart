extension StringExtensions on String {
  /// Gets the first two letters of a name
  String get getInitials {
    final cleanName = trim();
    if (cleanName.isEmpty) return 'JD';
    if (cleanName.length == 1) return cleanName.toUpperCase();
    return cleanName.substring(0, 2).toUpperCase();
  }
}
