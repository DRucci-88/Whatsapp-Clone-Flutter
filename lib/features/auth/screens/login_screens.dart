import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/common/widgets/custom_button.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneCtl = TextEditingController();

  Country? _country;

  @override
  void dispose() {
    _phoneCtl.dispose();
    super.dispose();
  }

  void _pickCountry() {
    showCountryPicker(
      context: context,
      onSelect: (Country value) {
        setState(() => _country = value);
      },
    );
  }

  void _sendPhoneNumber() {
    String phoneNumber = _phoneCtl.text.trim();
    // print(_country.);
    print('+${_country?.phoneCode}$phoneNumber');
    if (_country == null || phoneNumber.isEmpty) {
      customShowSnackbar(context: context, content: 'Fill out all the fields');
      return;
    }
    ref.read(authControllerProvider).signInWithPhone(
          context: context,
          phoneNumber: '+${_country!.phoneCode}$phoneNumber',
        ); // +62......
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your phone number'),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Whatsapp will need to verify your phone number.'),
            const SizedBox(height: 10),
            TextButton(
              onPressed: _pickCountry,
              child: const Text('Pick country'),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                if (_country != null) Text('+${_country!.phoneCode}'),
                // if (_country == null) const Text('+62'),
                const SizedBox(width: 10),
                SizedBox(
                  width: size.width * 0.7,
                  child: TextField(
                    controller: _phoneCtl,
                    decoration: const InputDecoration(hintText: "phone number"),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: 90,
              child: CustomButton(
                text: 'Next',
                onPressed: _sendPhoneNumber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
