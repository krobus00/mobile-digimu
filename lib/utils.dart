import 'package:flutter/widgets.dart';

Color drakenColor(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

String? getErrorMessage(String field, List<dynamic> errors) {
  for (var v in errors) {
    if (v.contains(field)) {
      return v;
    }
  }
  return null;
}

// unfocus any textfield in context
unfocus(BuildContext context) {
  var currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}
