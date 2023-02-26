import 'package:flutter/material.dart';
import 'package:whatsapp_clone/widgets/contacts_list.dart';

class WebScreenLayout1 extends StatelessWidget {
  const WebScreenLayout1({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 200,
                maxWidth: 400,
              ),
              child: Column(
                children: [
                  /// Web Profile Bar
                  /// Web Search Bar
                  /// Contact List
                  Container(
                    // constraints: BoxConstraints(
                    //   maxHeight: screenSize.height * 0.8,
                    //   maxWidth: screenSize.width * 0.8,
                    // ),
                    child: const ContactsList(),
                  ),
                ],
              ),
            ),
          ),

          /// Web Screen
          Expanded(
            child: Container(
              // constraints: const BoxConstraints(
              //   minWidth: 300,
              //   maxWidth: 600,
              // ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/backgroundImage.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
