import 'package:flutter/material.dart';

void customShowSnackbar({
  required BuildContext context,
  required String content,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
