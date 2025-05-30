import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:medvisual/src/core/widgets/base_button.dart';
import 'package:medvisual/src/router/router.dart';

@RoutePage()
class AIChatsScreen extends StatelessWidget {
  const AIChatsScreen({super.key});

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
                title: Text('MedGPT'),
                surfaceTintColor: theme.colorScheme.surface,
                backgroundColor: theme.colorScheme.surface,
                centerTitle: true,
                pinned: true,
              ),
              SliverList.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return HistoryListElement();
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
                    context.router.push(const ChatbotRoute());
                  },
                  text: 'Новый чат',
                  margin: EdgeInsets.symmetric(horizontal: 130),
                )),
          ),
        ],
      ),
    );
  }
}

class HistoryListElement extends StatelessWidget {
  const HistoryListElement({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(
        'Текстовые названия DioHыоesada',
        overflow: TextOverflow.fade,
        softWrap: false,
      ),
      subtitle: Text(
        '20:20',
        style: TextStyle(color: theme.hintColor),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 20,
      ),
    );
  }
}
