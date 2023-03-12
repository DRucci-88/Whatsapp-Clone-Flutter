import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/widgets/error.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/features/select_contacts/controller/select_contact_controller.dart';

class SelectContactsScreen extends ConsumerWidget {
  static const routeName = '/select-contact';
  const SelectContactsScreen({super.key});

  void _selectContact(
    WidgetRef ref,
    Contact selectedContact,
    BuildContext context,
  ) {
    ref.read(selectContactControllerProvider).selectContact(
          selectedContact: selectedContact,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select contact'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ref.watch(getContactsProvider).when(
        data: (contacts) {
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return itemContactTile(ref, contacts[index], context);
            },
          );
        },
        error: (error, stackTrace) {
          return ErrorScreen(text: error.toString());
        },
        loading: () {
          return const Loader();
        },
      ),
    );
  }

  Widget itemContactTile(WidgetRef ref, Contact contact, BuildContext context) {
    return InkWell(
      onTap: () => _selectContact(ref, contact, context),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ListTile(
          leading: contact.photoOrThumbnail == null
              ? null
              : CircleAvatar(
                  backgroundImage: MemoryImage(
                    contact.photoOrThumbnail!,
                  ),
                  radius: 30,
                ),
          title: Text(
            contact.displayName,
            style: const TextStyle(fontSize: 18),
          ),
          subtitle: Text(contact.phones[0].number),
        ),
      ),
    );
  }
}
