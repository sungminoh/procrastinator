extension StringExtensions on String {
  bool get isNullOrEmpty => this == null || isEmpty;
  bool get isNullOrWhiteSpace => this == null || trim().isEmpty;
}