part of './router.dart';

/// This class have all the routes based on navigation.
///
/// While adding any additional routes to the scope, you need to register all
/// the routes below here, and all the refrences towards any dynamic path
/// should be redirected from this class.
///
/// make sure to register all the routes here.
class Routes {
  static final startPage = DynamicRoutes(
    name: 'Start',
    path: '/',
  );

  static final privateRoute = DynamicRoutes(
    name: 'Private Pages',
    path: '/private',
  );

  // splash routes
  static final splash = DynamicRoutes(
    name: 'Private Pages',
    path: '/private',
  );

  static final authLogin = AuthRoutes.loginRoute;
  static final authSignUp = AuthRoutes.signUpRoute;
  static final homePage = TaskListRoutes.homeRoute;
}
