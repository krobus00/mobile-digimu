class Validation {
  String? error;

  Validation(this.error);

  clearError() {
    error = null;
  }
}

class ValidationStringModel extends Validation {
  String? value;
  ValidationStringModel(String? error, this.value) : super(error);
}

class ValidationIntModel extends Validation {
  int? value;
  ValidationIntModel(String? error, this.value) : super(error);
}

class ValidationDoubleModel extends Validation {
  double? value;
  ValidationDoubleModel(String? error, this.value) : super(error);
}
