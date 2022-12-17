import 'package:flutter/material.dart';

import 'package:bills_out/utilities/dialog/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: 'Log out',
      content: "Are you sure you want to delete this item?",
      optionBuilder: () => {
            'Cancel': false,
            'Yes': true,
          }).then((value) => value ?? false);
}
