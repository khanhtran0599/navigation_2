import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:navigation_2/feature/chat/data/model/message_model.dart';
import 'package:navigation_2/feature/chat/domain/entities/user_entity.dart';

abstract class ChatRemoteDataSource {
  Future<void> sendMessage(MessageModel message);
  Stream<List<MessageModel>> getMessages(String senderId, String receiverId);
  Future<List<UserEntity>> getAllUsers();
  Future<String> uploadImage(File file, String senderId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  ChatRemoteDataSourceImpl({
    required this.firestore,
    required this.storage,
  });

  String _getChatId(String id1, String id2) {
    List<String> ids = [id1, id2];
    ids.sort();
    return ids.join('_');
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    final chatId = _getChatId(message.senderId, message.receiverId);
    await firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message.toJson());
  }

  @override
  Stream<List<MessageModel>> getMessages(String senderId, String receiverId) {
    final chatId = _getChatId(senderId, receiverId);
    return firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MessageModel.fromJson(doc.data(), doc.id))
          .toList();
    });
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    final snapshot = await firestore.collection('users').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return UserEntity(
        id: doc.id,
        name: data['name'] ?? 'Unknown User',
      );
    }).toList();
  }

  @override
  Future<String> uploadImage(File file, String senderId) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}_$senderId.jpg';
    final ref = storage.ref().child('chat_images').child(fileName);
    final uploadTask = await ref.putFile(file);
    return await uploadTask.ref.getDownloadURL();
  }
}
