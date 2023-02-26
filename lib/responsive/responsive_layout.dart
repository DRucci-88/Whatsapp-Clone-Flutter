import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
  });
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        /// WEBSITES
        if (constraint.maxWidth > 900) {
          return webScreenLayout;
        }

        /// Mobile Screen
        return mobileScreenLayout;

        /// Tablet
        // else if (constraint.maxWidth > 600) {
        //   return null;
        // }
      },
    );
  }
}
