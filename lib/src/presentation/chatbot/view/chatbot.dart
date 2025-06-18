// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:convert'; // For jsonEncode

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medvisual/src/core/services/ai_service.dart';
import 'package:medvisual/src/data/local/models/chat_history.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:realm/realm.dart'
    as realm_sdk; // Aliasing to avoid any potential conflicts
import 'package:firebase_vertexai/firebase_vertexai.dart'
    as vertex_ai; // Aliasing to avoid conflict

// Adjust the path to your generated Realm model file

import 'package:medvisual/src/core/widgets/widgets.dart';

@RoutePage()
class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen(
      {super.key,
      this.messages,
      required this.chatName,
      required this.currentChatId});

  final String chatName;
  final String currentChatId;

  // This 'messages' parameter from the constructor is for initial messages,
  // but we will primarily rely on loading from/saving to _aiService.chatInstance.history
  final List<Message>? messages;

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  bool _inputHasText = false;
  bool _reasonButtonSelected = false;
  bool _searchButtonSelected = false;
  final _aiService = VirtualDoctorService();
  final TextEditingController _textController = TextEditingController();
  final GlobalKey _menuButtonKey = GlobalKey();
  late List<Message> _messages; // This list is for UI display
  final ScrollController _scrollController = ScrollController();
  bool _isAiTyping = false;

  // Realm instance
  late realm_sdk.Realm _realmInstance;

  @override
  void initState() {
    super.initState();
    _realmInstance = GetIt.I<realm_sdk.Realm>();
    // Initialize _messages.
    // For now, we are not loading history here, only using initial constructor messages or an empty list.
    // Loading will be a separate step.
    _messages = widget.messages ?? [];

    // If _aiService.chatInstance.history is already populated (e.g., from a previous session in a more complex setup),
    // you might want to convert it to your UI _messages list here.
    // For now, we assume _aiService.chatInstance.history starts fresh or is managed by _aiService.
    // This example focuses on *saving* on exit.

    _textController.addListener(_onTextInput);
  }

  @override
  void dispose() {
    _saveHistory();
    _textController.removeListener(_onTextInput);
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _saveHistory() {
    final history = _aiService.chatInstance.history.toList();
    if (history.isEmpty) {
      log('Нет сообщений для сохранения. Ошибка сохранения чата');
      return;
    }
    final serializedHistory = history.map((e) => e.toChatMessage());
    final chatHistory = ChatHistory(
        widget.currentChatId.toString(), widget.chatName,
        messages: serializedHistory);
    _realmInstance.write(() {
      _realmInstance.add(chatHistory, update: true);
    });
  }

  void _onTextInput() {
    final hasText = _textController.text.isNotEmpty;
    if (hasText != _inputHasText) {
      setState(() {
        _inputHasText = hasText;
      });
    }
  }

  void _scrollToBottom({bool? responsePart}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final currentPosition = _scrollController.position.pixels;
        final maxScroll = _scrollController.position.maxScrollExtent;
        if (maxScroll - currentPosition > 40 && responsePart == true) {
          return;
        }
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _sendMessage() {
    final inputText = _textController.text.trim();
    if (inputText.isEmpty) {
      return;
    }
    _textController.clear();

    // Add user's message to the UI list
    final uiUserMessage = Message(author: Role.user, content: inputText);
    setState(() {
      _messages.add(uiUserMessage);
    });
    _scrollToBottom();

    // The _aiService.getChatStream will internally add this prompt to its own history.
    // We don't need to manually add vertex_ai.Content.text(inputText) to _aiService.chatInstance.history here.

    final aiMessagePlaceholderIndex = _messages.length;
    setState(() {
      _messages.add(Message(author: Role.model, content: ''));
      _isAiTyping = true;
    });
    _scrollToBottom();

    _aiService.getChatStream(prompt: inputText).listen(
      (aiResponseChunk) {
        setState(() {
          final currentUiMessage = _messages[aiMessagePlaceholderIndex];
          _messages[aiMessagePlaceholderIndex] = Message(
            author: currentUiMessage.author,
            content: currentUiMessage.content + aiResponseChunk,
          );
        });
        _scrollToBottom(responsePart: true);
      },
      onError: (error, stackTrace) {
        log('Ошибка потока виртуального доктора: $error',
            error: error, stackTrace: stackTrace);
        setState(() {
          _messages[aiMessagePlaceholderIndex] = Message(
            author: Role.model,
            content: 'Произошла ошибка. Пожалуйста, попробуйте еще раз.',
          );
          _isAiTyping = false;
        });
        _scrollToBottom();
      },
      onDone: () {
        setState(() {
          _isAiTyping = false;
        });
        // After the AI is done, its full response is now part of _aiService.chatInstance.history
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: theme.colorScheme.surface,
          backgroundColor: theme.colorScheme.surface,
          toolbarHeight: 0,
        ),
        body: Column(
          children: [
            _messages.isEmpty
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/chatgpt_icon.png",
                              width: 50,
                              height: 50,
                              color: theme.colorScheme.onSurfaceVariant),
                          const SizedBox(height: 15),
                          Text(
                            'Начните чат с ИИ',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurfaceVariant,
                              fontFamily: GoogleFonts.raleway().fontFamily,
                            ),
                          ),
                          Text(
                            'Вы можете задавать вопросы или просить совета',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurfaceVariant
                                  .withAlpha(160),
                              fontFamily: GoogleFonts.raleway().fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final currentMessage = _messages[index];
                        final isUser = currentMessage.author == Role.user;
                        if (isUser) {
                          return UserMessageWidget(
                              currentMessage: currentMessage);
                        } else {
                          bool showTypingIndicator = _isAiTyping &&
                              index == _messages.length - 1 &&
                              currentMessage.content.isEmpty;

                          return AiMessageWidget(
                            // Not using MarkdownWidget here as per your request not to change UI
                            currentMessage: currentMessage,
                            isTyping: showTypingIndicator,
                          );
                        }
                      },
                    ),
                  ),
            _buildTextInputField(context)
          ],
        ),
      ),
    );
  }

  Widget _buildTextInputField(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainer,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 150),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Спросите что-нибудь...',
                  hintStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: theme.hintColor.withAlpha((0.8 * 255).round()),
                    fontFamily: GoogleFonts.raleway().fontFamily,
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const SizedBox(width: 8),
                VisualIconButton(
                  key: _menuButtonKey,
                  onPressed: _showCupertinoMenu,
                  icon: const Icon(Icons.add, size: 26),
                  borderWidth: 1.5,
                  buttonRadius: 8,
                  borderColor: Colors.grey.withAlpha(100),
                ),
                const SizedBox(width: 8),
                VisualIconButton(
                  onPressed: _onReasonButtonTap,
                  icon: Icon(
                    Icons.lightbulb_outline_rounded,
                    size: 24,
                    color: _reasonButtonSelected
                        ? theme.primaryColor
                        : theme.iconTheme.color?.withAlpha((0.7 * 255).round()),
                  ),
                  backgroundColor: _reasonButtonSelected
                      ? theme.primaryColor.withAlpha(60)
                      : null,
                  borderWidth: 1.5,
                  buttonRadius: 8,
                  borderColor: _reasonButtonSelected
                      ? theme.primaryColor.withAlpha((0.7 * 255).round())
                      : Colors.grey.withAlpha(100),
                ),
                const SizedBox(width: 8),
                VisualIconButton(
                  onPressed: _onSearchButtonTap,
                  icon: Icon(
                    Icons.language,
                    size: 24,
                    color: _searchButtonSelected
                        ? theme.primaryColor
                        : theme.iconTheme.color?.withAlpha((0.7 * 255).round()),
                  ),
                  backgroundColor: _searchButtonSelected
                      ? theme.primaryColor.withAlpha(60)
                      : null,
                  borderWidth: 1.5,
                  buttonRadius: 8,
                  borderColor: _searchButtonSelected
                      ? theme.primaryColor.withAlpha((0.7 * 255).round())
                      : Colors.grey.withAlpha(100),
                ),
                const Spacer(),
                VisualIconButton(
                  backgroundColor: _inputHasText
                      ? theme.primaryColor
                      : theme.disabledColor.withAlpha(120),
                  onPressed: _inputHasText ? _sendMessage : null,
                  icon: const Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                    size: 26,
                  ),
                  buttonRadius: 8,
                ),
                const SizedBox(width: 8)
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCupertinoMenu() async {
    final RenderBox? buttonBox =
        _menuButtonKey.currentContext?.findRenderObject() as RenderBox?;

    if (buttonBox == null) return;
    final Offset buttonTopLeft = buttonBox.localToGlobal(Offset.zero);
    const double estimatedMenuHeight = 150.0;
    const double gap = 5.0;
    final Rect menuPosition = Rect.fromLTWH(
        buttonTopLeft.dx,
        buttonTopLeft.dy - estimatedMenuHeight - gap,
        buttonBox.size.width + 40,
        estimatedMenuHeight);

    await showPullDownMenu(
      context: context,
      position: menuPosition,
      items: [
        PullDownMenuItem(
            onTap: () {}, title: 'Фото', icon: CupertinoIcons.photo),
        PullDownMenuItem(
            onTap: () {}, title: 'Камера', icon: CupertinoIcons.camera),
        PullDownMenuItem(
            onTap: () {}, title: 'Файлы', icon: CupertinoIcons.folder),
      ],
    );
  }

  void _onReasonButtonTap() {
    setState(() {
      _reasonButtonSelected = !_reasonButtonSelected;
    });
  }

  void _onSearchButtonTap() {
    setState(() {
      _searchButtonSelected = !_searchButtonSelected;
    });
  }
}

// Your UserMessageWidget and AiMessageWidget (original, without MarkdownWidget)
class UserMessageWidget extends StatelessWidget {
  const UserMessageWidget({
    super.key,
    required this.currentMessage,
  });

  final Message currentMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(width: 50),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(4))),
              child: Text(
                currentMessage.content,
                softWrap: true,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white, // This was your original color
                  fontFamily: GoogleFonts.raleway().fontFamily,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AiMessageWidget extends StatelessWidget {
  const AiMessageWidget({
    super.key,
    required this.currentMessage,
    this.isTyping = false,
  });

  final Message currentMessage;
  final bool isTyping;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isTyping) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
                backgroundColor:
                    theme.colorScheme.onSurface.withAlpha((0.8 * 255).round()),
                child: Image.asset(
                  width: 25,
                  height: 25,
                  "assets/images/chatgpt_icon.png",
                  color: theme.colorScheme.surface,
                )),
            const SizedBox(width: 10),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: CupertinoActivityIndicator(radius: 10),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              backgroundColor:
                  theme.colorScheme.onSurface.withAlpha((0.8 * 255).round()),
              child: Image.asset(
                width: 25,
                height: 25,
                "assets/images/chatgpt_icon.png",
                color: theme.colorScheme.surface,
              )),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(18),
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18))),
                  child: Text(
                    // Using Text widget as requested
                    currentMessage.content.isEmpty && !isTyping
                        ? "..."
                        : currentMessage.content,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurfaceVariant,
                      fontFamily: GoogleFonts.raleway().fontFamily,
                    ),
                  ),
                ),
                if (currentMessage.content.isNotEmpty && !isTyping) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          icon: Icon(Icons.copy_rounded,
                              color: theme.hintColor, size: 20),
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: currentMessage.content));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Скопировано в буфер обмена!'),
                              duration: Duration(seconds: 1),
                            ));
                          },
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero),
                      const SizedBox(width: 4),
                      IconButton(
                          icon: Icon(Icons.replay,
                              color: theme.hintColor, size: 20),
                          onPressed: () {/* TODO: Повторить */},
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero),
                      const SizedBox(width: 4),
                      IconButton(
                          icon: Icon(Icons.thumb_up_off_alt_outlined,
                              color: theme.hintColor, size: 20),
                          onPressed: () {/* TODO: Нравится */},
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero),
                      const SizedBox(width: 4),
                      IconButton(
                          icon: Icon(Icons.thumb_down_off_alt_rounded,
                              color: theme.hintColor, size: 20),
                          onPressed: () {/* TODO: Не нравится */},
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero),
                    ],
                  )
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Your local Message class and Role enum
class Message {
  Message({
    required this.author,
    required this.content,
  });

  final Role author;
  final String content;
}

enum Role { model, user }
