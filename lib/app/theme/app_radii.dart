import 'package:flutter/widgets.dart';

class AppRadii {
  const AppRadii._();

  static const sm = Radius.circular(12);
  static const md = Radius.circular(18);
  static const lg = Radius.circular(24);
  static const xl = Radius.circular(28);

  static const card = BorderRadius.all(lg);
  static const input = BorderRadius.all(md);
  static const sheet = BorderRadius.vertical(top: xl);
  static const pill = BorderRadius.all(Radius.circular(999));
}
