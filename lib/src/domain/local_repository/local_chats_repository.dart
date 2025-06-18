import 'package:medvisual/src/data/local/models/chat_history.dart';

abstract interface class LocalChatRepository {
  Future<List<ChatHistory>> getChats();
  Future<void> saveChat(List<ChatHistory> chat);
  Future<void> deleteChat(int chatId);
  Future<void> clear();
}
