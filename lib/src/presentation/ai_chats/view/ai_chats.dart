import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/core/widgets/base_button.dart';
import 'package:medvisual/src/data/local/models/chat_history.dart';
import 'package:medvisual/src/presentation/chatbot/view/chatbot.dart';
import 'package:medvisual/src/router/router.dart';
import 'package:realm/realm.dart';

@RoutePage()
class AIChatsScreen extends StatefulWidget {
  const AIChatsScreen({super.key});

  @override
  State<AIChatsScreen> createState() => _AIChatsScreenState();
}

class _AIChatsScreenState extends State<AIChatsScreen> {
  final List<ChatHistory> _chats = [];
  late final StreamSubscription _realmSub;
  late final Realm _realm;

  @override
  void initState() {
    super.initState();
    _realm = GetIt.I<Realm>();
    _syncChats();
  }

  _syncChats() {
    try {
      final chatsRealm = _realm.all<ChatHistory>();
      final chats = chatsRealm.toList();

      _chats.addAll(chats.toList());
      _realmSub = chatsRealm.changes.listen((changes) {
        log('Получено изменение базы данных');
        setState(() {
          _chats.clear();
          _chats.addAll(changes.results.toList());
        });
      });
// ignore: empty_catches
    } catch (e) {}
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _realmSub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: CustomScrollView(slivers: [
              SliverAppBar(
                title: const Text('MedGPT'),
                surfaceTintColor: theme.colorScheme.surface,
                backgroundColor: theme.colorScheme.surface,
                centerTitle: true,
                pinned: true,
              ),
              SliverList.builder(
                  itemCount: _chats.length,
                  itemBuilder: (context, index) {
                    return HistoryListElement(
                      onTap: () {
                        final currentElement = _chats[index];
                        final messages = currentElement.messages.map((e) {
                          final Role role =
                              e.role == 'user' ? Role.user : Role.model;

                          return Message(author: role, content: e.text);
                        }).toList();
                        context.router
                            .push(ChatbotRoute(
                                chatName: currentElement.name,
                                currentChatId: currentElement.id,
                                messages: messages))
                            .then((object) {
                          setState(() {});
                        });
                      },
                      chat: _chats[index],
                    );
                  })
            ]),
          ),
          Positioned(
            bottom: 85,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: BaseButton(
                  onPressed: () {
                    context.router.push(ChatbotRoute(
                        chatName: 'Название чата',
                        currentChatId: Uuid.v4().toString()));
                  },
                  text: 'Новый чат',
                  margin: const EdgeInsets.symmetric(horizontal: 130),
                )),
          ),
        ],
      ),
    );
  }
}

class HistoryListElement extends StatelessWidget {
  const HistoryListElement(
      {super.key, required this.chat, required this.onTap});

  final ChatHistory chat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      title: Text(
        chat.name,
        overflow: TextOverflow.fade,
        softWrap: false,
      ),
      subtitle: Text(
        '20:20',
        style: TextStyle(color: theme.hintColor),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 20,
      ),
    );
  }
}
