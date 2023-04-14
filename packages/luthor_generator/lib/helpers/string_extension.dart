extension StringX on String {
  String pascalToCamelCase() {
    if (isEmpty) return this;
    if (length == 1) return toLowerCase();
    return '${this[0].toLowerCase()}${substring(1)}';
  }
}
