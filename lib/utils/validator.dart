class Validator {
  static String? inputEmptyTextChecker(String? text) {
    if (text == null || text.isEmpty) {
      return 'Field is required';
    }
    return null;
  }
}
