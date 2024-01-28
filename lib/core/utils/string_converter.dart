class StringConverter {
  int? stringConverter(String? string) => int.tryParse(string ?? '');
}
