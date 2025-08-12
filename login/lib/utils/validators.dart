// TODO Implement this library.
class Validators {
  static final RegExp _emailRegExp = RegExp(
    r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
  );

  static final RegExp _passwordRegExp = RegExp(
    // Minimum 8 chars, at least 1 uppercase, 1 lowercase, 1 digit and 1 symbol
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$',
  );

  static bool isValidEmail(String email) => _emailRegExp.hasMatch(email);
  static bool isValidPassword(String pass) => _passwordRegExp.hasMatch(pass);
}
