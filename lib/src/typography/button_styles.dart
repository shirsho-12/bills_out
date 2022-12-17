import 'package:flutter/material.dart';

import '../colors.dart';

class BillButtonStyle {
  static ButtonStyle get enabled {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(BillsColors.black),
      foregroundColor: MaterialStateProperty.all(BillsColors.white),
      elevation: MaterialStateProperty.all(0),
    );
  }

  static ButtonStyle get disabled {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(BillsColors.gray),
      foregroundColor: MaterialStateProperty.all(BillsColors.white),
      elevation: MaterialStateProperty.all(0),
    );
  }
}
