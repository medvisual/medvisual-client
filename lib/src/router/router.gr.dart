// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [AIChatsScreen]
class AIChatsRoute extends PageRouteInfo<void> {
  const AIChatsRoute({List<PageRouteInfo>? children})
      : super(
          AIChatsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AIChatsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AIChatsScreen();
    },
  );
}

/// generated route for
/// [AddDiseasePage]
class AddDiseaseRoute extends PageRouteInfo<AddDiseaseRouteArgs> {
  AddDiseaseRoute({
    Key? key,
    required void Function() onResult,
    List<PageRouteInfo>? children,
  }) : super(
          AddDiseaseRoute.name,
          args: AddDiseaseRouteArgs(
            key: key,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'AddDiseaseRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddDiseaseRouteArgs>();
      return AddDiseasePage(
        key: args.key,
        onResult: args.onResult,
      );
    },
  );
}

class AddDiseaseRouteArgs {
  const AddDiseaseRouteArgs({
    this.key,
    required this.onResult,
  });

  final Key? key;

  final void Function() onResult;

  @override
  String toString() {
    return 'AddDiseaseRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [CategoriesScreen]
class CategoriesRoute extends PageRouteInfo<void> {
  const CategoriesRoute({List<PageRouteInfo>? children})
      : super(
          CategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CategoriesScreen();
    },
  );
}

/// generated route for
/// [ChatbotScreen]
class ChatbotRoute extends PageRouteInfo<void> {
  const ChatbotRoute({List<PageRouteInfo>? children})
      : super(
          ChatbotRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatbotRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ChatbotScreen();
    },
  );
}

/// generated route for
/// [DiseasesScreen]
class DiseasesRoute extends PageRouteInfo<DiseasesRouteArgs> {
  DiseasesRoute({
    Key? key,
    required String category,
    bool showCheckboxes = false,
    void Function(Set<String>)? onResult,
    Set<String>? initialSelectedDiseases,
    List<PageRouteInfo>? children,
  }) : super(
          DiseasesRoute.name,
          args: DiseasesRouteArgs(
            key: key,
            category: category,
            showCheckboxes: showCheckboxes,
            onResult: onResult,
            initialSelectedDiseases: initialSelectedDiseases,
          ),
          initialChildren: children,
        );

  static const String name = 'DiseasesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DiseasesRouteArgs>();
      return DiseasesScreen(
        key: args.key,
        category: args.category,
        showCheckboxes: args.showCheckboxes,
        onResult: args.onResult,
        initialSelectedDiseases: args.initialSelectedDiseases,
      );
    },
  );
}

class DiseasesRouteArgs {
  const DiseasesRouteArgs({
    this.key,
    required this.category,
    this.showCheckboxes = false,
    this.onResult,
    this.initialSelectedDiseases,
  });

  final Key? key;

  final String category;

  final bool showCheckboxes;

  final void Function(Set<String>)? onResult;

  final Set<String>? initialSelectedDiseases;

  @override
  String toString() {
    return 'DiseasesRouteArgs{key: $key, category: $category, showCheckboxes: $showCheckboxes, onResult: $onResult, initialSelectedDiseases: $initialSelectedDiseases}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    Key? key,
    required VoidCallback onResult,
    required VoidCallback onRegistration,
    List<PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            onResult: onResult,
            onRegistration: onRegistration,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>();
      return LoginPage(
        key: args.key,
        onResult: args.onResult,
        onRegistration: args.onRegistration,
      );
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    required this.onResult,
    required this.onRegistration,
  });

  final Key? key;

  final VoidCallback onResult;

  final VoidCallback onRegistration;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onResult: $onResult, onRegistration: $onRegistration}';
  }
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [RegistrationPage]
class RegistrationRoute extends PageRouteInfo<RegistrationRouteArgs> {
  RegistrationRoute({
    Key? key,
    required VoidCallback onResult,
    List<PageRouteInfo>? children,
  }) : super(
          RegistrationRoute.name,
          args: RegistrationRouteArgs(
            key: key,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'RegistrationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegistrationRouteArgs>();
      return RegistrationPage(
        key: args.key,
        onResult: args.onResult,
      );
    },
  );
}

class RegistrationRouteArgs {
  const RegistrationRouteArgs({
    this.key,
    required this.onResult,
  });

  final Key? key;

  final VoidCallback onResult;

  @override
  String toString() {
    return 'RegistrationRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [SearchScreen]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute({List<PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SearchScreen();
    },
  );
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsScreen();
    },
  );
}

/// generated route for
/// [VisualScreen]
class VisualRoute extends PageRouteInfo<VisualRouteArgs> {
  VisualRoute({
    Key? key,
    required String disease,
    required int diseaseId,
    required String category,
    List<PageRouteInfo>? children,
  }) : super(
          VisualRoute.name,
          args: VisualRouteArgs(
            key: key,
            disease: disease,
            diseaseId: diseaseId,
            category: category,
          ),
          initialChildren: children,
        );

  static const String name = 'VisualRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VisualRouteArgs>();
      return VisualScreen(
        key: args.key,
        disease: args.disease,
        diseaseId: args.diseaseId,
        category: args.category,
      );
    },
  );
}

class VisualRouteArgs {
  const VisualRouteArgs({
    this.key,
    required this.disease,
    required this.diseaseId,
    required this.category,
  });

  final Key? key;

  final String disease;

  final int diseaseId;

  final String category;

  @override
  String toString() {
    return 'VisualRouteArgs{key: $key, disease: $disease, diseaseId: $diseaseId, category: $category}';
  }
}
