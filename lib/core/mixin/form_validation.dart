//form validation function

mixin FormValidation {
  String checkString(String string) {
    if (string.length <= 0) {
      return "Username must be written";
    } else
      return null;
  }
}
