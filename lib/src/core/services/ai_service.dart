import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/core/constants/ai_constants.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Service for working with virtual doctor based on gemini-vertex-ai system
/// [getChatStream] is function for send message to virtual doctor
class VirtualDoctorService {
  static const String _modelName = 'gemini-2.5-pro-preview-03-25';
  GenerativeModel? _model;
  ChatSession? _chatSession;

  GenerativeModel get _modelInstance {
    _model ??= FirebaseVertexAI.instance.generativeModel(
        model: _modelName,
        systemInstruction: Content.text(AIConstants.generalInstruction));
    return _model!;
  }

  ChatSession get chatInstance {
    _chatSession ??= _modelInstance.startChat();
    return _chatSession!;
  }

  Stream<String> getChatStream({required String prompt}) {
    try {
      final messageStream =
          chatInstance.sendMessageStream(Content.text(prompt));
      return messageStream
          .map((resp) => resp.text ?? '')
          .where((text) => text.isNotEmpty);
    } catch (e) {
      GetIt.I<Talker>().error('Virtual Doctor Error: $e');
      return Stream<String>.error('Virtual Doctor Error: $e');
    }
  }
}
