import 'dart:io';

import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatRepository {
  Future<void> addUserInfo(userData) async {
    // Firebase removed - method stubbed for compatibility
  }

  getUserInfo(String? token) async {
    // Firebase removed - method stubbed for compatibility
    return null;
  }

  searchByName(String? searchField) {
    // Firebase removed - method stubbed for compatibility
    return Stream.value([]);
  }

  // Create Message
  Future<void> createMessage(Message message) {
    // Firebase removed - method stubbed for compatibility
    return Future.value();
  }

  // to remove message from firebase
  Future<void> deleteMessage(Message message) {
    // Firebase removed - method stubbed for compatibility
    return Future.value();
  }

  Stream getUserMessages(String? userId, {perPage = 10}) {
    // Firebase removed - method stubbed for compatibility
    return Stream.value([]);
  }

  Future<Message> getMessage(Message message) {
    // Firebase removed - method stubbed for compatibility
    return Future.value(message);
  }

  Stream getUserMessagesStartAt(String? userId, dynamic lastDocument, {perPage = 10}) {
    // Firebase removed - method stubbed for compatibility
    return Stream.value([]);
  }

  Stream<List<Chat>> getChats(Message message) {
    // Firebase removed - method stubbed for compatibility
    updateMessage(message.id, {'read_by_users': message.readByUsers});
    return Stream.value(<Chat>[]);
  }

  Future<void> addMessage(Message message, Chat chat) {
    // Firebase removed - method stubbed for compatibility
    updateMessage(message.id, message.toUpdatedMap());
    return Future.value();
  }

  Future<void> updateMessage(String? messageId, Map<String, dynamic> message) {
    // Firebase removed - method stubbed for compatibility
    return Future.value();
  }

  Future<String> uploadFile(File _imageFile) async {
    // Firebase removed - file upload disabled
    throw Exception('File upload is not available - Firebase has been removed');
  }
}
