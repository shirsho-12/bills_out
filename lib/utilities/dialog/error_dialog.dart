import 'package:flutter/material.dart';
import 'package:bills_out/utilities/dialog/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: 'An error has occured',
    content: text,
    optionBuilder: () => {
      'OK': null,
    },
  );
}
