// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import 'package:whatsapp_clone/screens/mobile_chat_screen.dart';

final selectContactsRepositoryProvider = Provider((ref) {
  return SelectContactRepository(firestore: FirebaseFirestore.instance);
});

class SelectContactRepository {
  final FirebaseFirestore firestore;
  SelectContactRepository({
    required this.firestore,
  });

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      /// Request permission for both Android and IOS
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectedContact(Contact selectedContact, context) async {
    try {
      debugPrint('select contact repo - selected contact - try');
      final userCollection = await firestore.collection('users').get();
      bool isFound = false;
      String selectedPhoneNumber = selectedContact.phones[0].number
          .replaceAll(' ', '')
          .replaceAll('-', '');
      debugPrint(selectedPhoneNumber);
      for (var document in userCollection.docs) {
        final userData = UserModel.fromMap(document.data());
        if (selectedPhoneNumber == userData.phoneNumber) {
          isFound = true;
          Navigator.pushNamed(context, MobileChatScreen.routeName);
          return;
        }
      }

      if (!isFound) {
        debugPrint('select contact repo - selected contact - try - not found');
        customShowSnackbar(
          context: context,
          content: 'This number does not exists on this app',
        );
      }
    } catch (e) {
      debugPrint('select contact repo - selected contact - catch');
      customShowSnackbar(context: context, content: e.toString());
    }
  }
}
