import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:realm/realm.dart';

part 'chat_history.realm.dart';

@RealmModel()
class _ChatMessage {
  late String role; // 'user' или 'model'
  late String text;
}

@RealmModel()
class _ChatHistory {
  @PrimaryKey()
  late String id;
  late String name;
  late List<_ChatMessage> messages;
}

extension ContentExtensions on Content {
  ChatMessage toChatMessage() {
    final textPart = parts.firstWhere((part) => part is TextPart) as TextPart;
    return ChatMessage(role ?? 'user', textPart.text);
  }
}

extension ChatMessageExtensions on ChatMessage {
  Content toContent() {
    return Content(role, [TextPart(text)]);
  }
}

Content chatMessageToContent(ChatMessage message) {
  return Content(message.role, [TextPart(message.text)]);
}
