extension ExtString on String? {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this ?? "");
  }

  bool get isNullOrEmpty {
    return this == null || this?.trim() == "";
  }

  bool parseBool() {
    if (this!.toLowerCase() == 'true') {
      return true;
    } else if (this!.toLowerCase() == 'false') {
      return false;
    }

    throw '"$this" can not be parsed to boolean.';
  }
}
