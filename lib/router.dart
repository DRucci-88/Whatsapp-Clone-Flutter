import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/widgets/error.dart';
import 'package:whatsapp_clone/features/auth/screens/login_screens.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());

    default:
      return MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text('Not Found')),
          body: const ErrorScreen(text: 'This page does not exists'),
        );
      });
  }
}
