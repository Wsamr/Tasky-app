class RegExpreForm {
  static final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final RegExp usernameRegExp = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
  static final RegExp passwordRegExp = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$',
  );
}
