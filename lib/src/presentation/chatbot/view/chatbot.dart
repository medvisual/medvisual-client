// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_down_button/pull_down_button.dart';

import 'package:medvisual/src/core/widgets/widgets.dart';

@RoutePage()
class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key, this.messages});

  final List<Message>? messages;

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  // Boolean variable, true only if TextField has text
  bool _inputHasText = false;
  bool _reasonButtonSelected = false;
  bool _searchButtonSelected = false;
  final TextEditingController _textController = TextEditingController();
  final GlobalKey _menuButtonKey = GlobalKey();
  late List<Message> _messages;

  @override
  void initState() {
    _messages = widget.messages ??
        [
          Message(
              author: Author.ai,
              content:
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
        ];
    _textController.addListener(_onTextInput);
    super.initState();
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextInput);
    _textController.dispose();
    super.dispose();
  }

  void _onTextInput() {
    final hasText = _textController.text.isNotEmpty;

    // Redraw only if state changed
    if (hasText != _inputHasText) {
      setState(() {
        _inputHasText = hasText;
      });
    }
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
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final currentMessage = _messages[index];
                      final isUser = currentMessage.author == Author.user;
                      return isUser
                          ? UserMessageWidget(currentMessage: currentMessage)
                          : AiMessageWidget(currentMessage: currentMessage);
                    })),
            _buildTextInputField(context)
          ],
        ),
      ),
    );
  }

  Widget _buildTextInputField(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainer,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: Scrollbar(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Спросите что-нибудь',
                      hintStyle: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: theme.hintColor,
                        fontFamily: GoogleFonts.raleway().fontFamily,
                      ),
                    ),
                    textInputAction: TextInputAction.newline,
                    minLines: 1,
                    maxLines: null,
                  ),
                ),
              ),
              Row(
                children: [
                  const SizedBox(width: 12),
                  VisualIconButton(
                    key: _menuButtonKey,
                    onPressed: _showCupertinoMenu,
                    icon: const Icon(
                      Icons.add,
                    ),
                    borderWidth: 2,
                    buttonRadius: 4,
                    borderColor: Colors.grey.withAlpha(120),
                  ),
                  const SizedBox(width: 10),
                  VisualIconButton(
                    onPressed: _onReasonButtonTap,
                    icon: Icon(
                      Icons.lightbulb_outline_rounded,
                      color: _reasonButtonSelected ? theme.primaryColor : null,
                    ),
                    backgroundColor: _reasonButtonSelected
                        ? theme.primaryColor.withAlpha(90)
                        : null,
                    borderWidth: 2,
                    buttonRadius: 4,
                    borderColor: _reasonButtonSelected
                        ? theme.primaryColor
                        : Colors.grey.withAlpha(120),
                  ),
                  const SizedBox(width: 10),
                  VisualIconButton(
                    onPressed: _onSearchButtonTap,
                    icon: Row(
                      children: [
                        Icon(
                          Icons.language,
                          color:
                              _searchButtonSelected ? theme.primaryColor : null,
                        ),
                      ],
                    ),
                    backgroundColor: _searchButtonSelected
                        ? theme.primaryColor.withAlpha(90)
                        : null,
                    borderWidth: 2,
                    buttonRadius: 4,
                    borderColor: _searchButtonSelected
                        ? theme.primaryColor
                        : Colors.grey.withAlpha(120),
                  ),
                  const Spacer(),
                  VisualIconButton(
                    backgroundColor: _inputHasText
                        ? theme.primaryColor
                        : theme.primaryColor.withAlpha(120),
                    onPressed: _sendMessage,
                    icon: const Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 15)
                ],
              ),
              const SizedBox(height: 5)
            ],
          ),
        ));
  }

  void _showCupertinoMenu() async {
    final RenderBox? buttonBox =
        _menuButtonKey.currentContext?.findRenderObject() as RenderBox?;

    if (buttonBox == null) return;

    final Offset buttonTopLeft = buttonBox.localToGlobal(Offset.zero);
    final Offset buttonBottomRight =
        buttonBox.localToGlobal(buttonBox.size.bottomRight(Offset.zero));

    final Offset upperPoint = buttonTopLeft.translate(10, -10);

    final Rect position = Rect.fromPoints(upperPoint, buttonBottomRight);

    await showPullDownMenu(
      context: context,
      items: [
        PullDownMenuItem(
          onTap: () {},
          title: 'Фотографии',
          icon: CupertinoIcons.photo,
        ),
        PullDownMenuItem(
          onTap: () {},
          title: 'Камера',
          icon: CupertinoIcons.camera,
        ),
        PullDownMenuItem(
          onTap: () {},
          title: 'Файлы',
          icon: CupertinoIcons.folder,
        ),
      ],
      position: position,
    );
  }

  void _sendMessage() {
    final inputText = _textController.text;
    // Check for non empty input
    if (inputText == "") {
      return;
    }
    _textController.clear();
    // Build message instance from input text
    final message = Message(author: Author.user, content: inputText);
    setState(() {
      _messages.add(message);
    });
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
      margin: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(width: 60),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainer,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(5))),
              child: Text(
                currentMessage.content,
                softWrap: true,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
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
  });

  final Message currentMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              backgroundColor: theme.colorScheme.onSurface,
              child: Image.asset(
                width: 27,
                height: 27,
                "assets/images/chatgpt_icon.png",
                color: theme.colorScheme.surface,
              )),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    currentMessage.content,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.raleway().fontFamily,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.copy_rounded,
                      color: theme.hintColor,
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.replay,
                      color: theme.hintColor,
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.thumb_up_off_alt_outlined,
                      color: theme.hintColor,
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.thumb_down_off_alt_rounded,
                      color: theme.hintColor,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  Message({
    required this.author,
    required this.content,
  });

  final Author author;
  final String content;
}

enum Author { ai, user }
