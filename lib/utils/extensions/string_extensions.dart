extension StringExtension on String {
  bool get isNullOrEmpty {
    return this == null || this.isEmpty;
  }
}

extension StringCasingExtension on String {
  String toCapitalize() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}
