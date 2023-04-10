abstract class Validation {
  String? fieldName;

  Validation();

  String? get message;

  bool call(String fieldName, dynamic value);
}
