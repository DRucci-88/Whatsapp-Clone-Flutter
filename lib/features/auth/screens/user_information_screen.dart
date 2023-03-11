import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-information';
  const UserInformationScreen({super.key});

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final _nameCtl = TextEditingController();

  File? _image;

  @override
  void dispose() {
    _nameCtl.dispose();
    super.dispose();
  }

  void _selectImage() async {
    _image = await pickImageFromGallery(context);
    setState(() {});
  }

  void _storeUserData() async {
    String name = _nameCtl.text.trim();

    if (name.isEmpty || _image == null) {
      customShowSnackbar(
        context: context,
        content: "Name and Image cannot be empty",
      );
      return;
    }

    ref.read(authControllerProvider).saveUserDataToFirebase(
          name: name,
          profilePic: _image,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  _image == null
                      ? const CircleAvatar(
                          backgroundImage:
                              NetworkImage('https://picsum.photos/200'),
                          radius: 64,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(_image!),
                          radius: 64,
                        ),
                  Positioned(
                    bottom: -10,
                    right: -10,
                    child: IconButton(
                      onPressed: _selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 0.85,
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: _nameCtl,
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _storeUserData,
                    icon: const Icon(Icons.done),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
