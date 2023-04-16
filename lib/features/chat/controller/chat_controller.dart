// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

import 'package:whatsapp_clone/features/chat/repository/chat_repository.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  void sendTextMessage({
    required context,
    required String text,
    required String receiverUserId,
  }) async {
    ref.read(userDataAuthProvider).whenData((value) {
      chatRepository.sendTextMessage(
        context: context,
        text: text,
        receiverUserId: receiverUserId,
        senderUserData: value!,
      );
    });
  }
}
