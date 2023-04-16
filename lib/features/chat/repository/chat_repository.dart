import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/models/chat_contact_model.dart';
import 'package:whatsapp_clone/models/message_model.dart';
import 'package:whatsapp_clone/models/user_model.dart';

final chatRepositoryProvider = Provider((ref) {
  return ChatRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  );
});

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({required this.firestore, required this.auth});

  void _saveDataToContactsSubColletion(
    UserModel senderUserData,
    UserModel receiverUserData,
    String text,
    DateTime timeSent,
    String receiverUserId,
  ) async {
    /// FOR CHAT CONTACT at HOME SCREEN - Displaying last message send and receiver profile
    /// users collection
    /// reveicer user id
    /// chats collection
    /// current user id
    /// set data
    final receiverChatContact = ChatContactModel(
      name: senderUserData.name,
      profilePic: senderUserData.profilePic,
      contactId: senderUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
    );
    await firestore
        .collection('users')
        .doc(receiverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(receiverChatContact.toMap());

    /// FOR CHAT CONTACT at HOME SCREEN - Displaying last message send and receiver profile
    /// users collection
    /// current user id
    /// chats collection
    /// reveicer user id
    /// set data
    final senderChatContact = ChatContactModel(
      name: receiverUserData.name,
      profilePic: receiverUserData.profilePic,
      contactId: receiverUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
    );
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .set(senderChatContact.toMap());
  }

  void _saveMessageToMessageSubcollection({
    required String receiverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String username,
    required String receiverUsername,
    required MessageEnum messageType,
  }) async {
    final message = MessageModel(
      senderId: auth.currentUser!.uid,
      recieverId: receiverUserId,
      text: text,
      type: MessageEnum.text,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
    );

    /// CHAT SCREEN For Sender - Displaying message for chatting
    /// users collection
    /// sender id
    /// receiver id
    /// messages collection
    /// message id
    /// store message
    ///
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .collection('message')
        .doc(messageId)
        .set(message.toMap());

    /// CHAT SCREEN For Receiver - Displaying message for chatting
    /// users collection
    /// receiver id
    /// sender id
    /// messages collection
    /// message id
    /// store message
    await firestore
        .collection('users')
        .doc(receiverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('message')
        .doc(messageId)
        .set(message.toMap());
  }

  Future<String> sendTextMessage({
    required context,
    required String text,
    required String receiverUserId,
    required UserModel senderUserData,
  }) async {
    try {
      final timeSent = DateTime.now();
      final userDataMap =
          await firestore.collection('users').doc(receiverUserId).get();
      final receiverUserData = UserModel.fromMap(userDataMap.data()!);

      final messageId = const Uuid().v1();

      _saveDataToContactsSubColletion(
          senderUserData, receiverUserData, text, timeSent, receiverUserId);

      _saveMessageToMessageSubcollection(
        receiverUserId: receiverUserId,
        text: text,
        timeSent: timeSent,
        messageId: messageId,
        username: senderUserData.name,
        receiverUsername: receiverUserData.name,
        messageType: MessageEnum.text,
      );
    } catch (e) {
      customShowSnackbar(context: context, content: e.toString());
    }
    return '';
  }
}
