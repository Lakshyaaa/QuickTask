import 'package:go_router/go_router.dart';
import 'package:quick_task/layout/screen1_layout.dart';

import '../../modules/modules.dart' as module;
import '../router.dart';

class AuthRoutes {
  static final loginRoute = DynamicRoutes(
    name: 'Login Page',
    path: 'login',
  );

  static final signUpRoute = DynamicRoutes(
    name: 'Signup Page',
    path: 'signup',
  );

  static GoRoute loginrouter() {
    return GoRoute(
      name: loginRoute.name,
      path: loginRoute.path,
      builder: (context, state) {
        return LayoutOne(
          title: loginRoute.name,
          child: const module.LoginPage(),
        );
      },
    );
  }

  static GoRoute signUprouter() {
    return GoRoute(
      name: signUpRoute.name,
      path: signUpRoute.path,
      builder: (context, state) {
        return LayoutOne(
          title: signUpRoute.name,
          child: const module.SignUpPage(),
        );
      },
    );
  }
}
