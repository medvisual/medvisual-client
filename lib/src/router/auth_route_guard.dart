import 'package:auto_route/auto_route.dart';
import 'package:medvisual/src/router/router.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // If auth == true //FIXME
    if (1 == 1) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}
