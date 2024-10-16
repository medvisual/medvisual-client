import 'package:flutter/material.dart';
import 'package:medvisual/src/ui/theme/theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            const CustomAppBar(),
            SliverList(
                delegate: SliverChildBuilderDelegate(childCount: 10,
                    (BuildContext context, int index) {
              return const BaseListContainer();
            })),
          ],
        ),
        bottomNavigationBar: const CustomNavigationBar());
  }
}

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    super.key,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: Theme.of(context).copyWith(
        // sets the background color of the `BottomNavigationBar`
        canvasColor: theme.primaryColor,
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30), label: 'Категории'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_rounded, size: 30), label: 'Избранное'),
          BottomNavigationBarItem(
              icon: Icon(Icons.mail_rounded, size: 30), label: 'Чаты'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30), label: 'Профиль'),
        ],
        selectedItemColor: const Color.fromARGB(255, 166, 188, 255),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class BaseListContainer extends StatelessWidget {
  const BaseListContainer({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: 75,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 59, 93, 196),
          borderRadius: BorderRadius.circular(20)),
      child: Center(
          child: Text(
        'Отделение',
        style:
            theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      )),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      title: Text(
        'Medvisual',
        style: theme.textTheme.titleLarge
            ?.copyWith(fontWeight: FontWeight.bold, fontSize: 30),
      ),
      backgroundColor: theme.primaryColor,
      surfaceTintColor: Colors.transparent,
      pinned: true,
      floating: true,
      bottom: const PreferredSize(
        preferredSize: Size(double.infinity, 70),
        child: SearchWidget(),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.search,
            color: theme.hintColor.withOpacity(0.5),
          ),
          const SizedBox(width: 10),
          Text(
            'Поиск',
            style: TextStyle(
                color: theme.hintColor.withOpacity(0.5),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
