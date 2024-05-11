import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_task/func/auth/auth_bloc.dart';
import 'package:quick_task/layout/screen1_layout.dart';
import 'package:quick_task/routes/modules/auth.route.dart';
import 'package:quick_task/routes/modules/taskbar.routes.dart';

part './routes.dart';

class DynamicRoutes {
  final String name;
  final String path;

  DynamicRoutes({
    required this.name,
    required this.path,
  });

  static bool isInitiated = false;

  static final router = GoRouter(
    restorationScopeId: "in_unwell",
    observers: [],
    routes: <RouteBase>[
      _start(),
      TaskListRoutes.loginrouter(),
    ],
  );

  static GoRoute _start() {
    return GoRoute(
      name: Routes.startPage.name,
      path: Routes.startPage.path,
      redirect: (context, state) {
        final session = BlocProvider.of<AuthBloc>(context).state;
        if (session is AuthSession) {
          return TaskListRoutes.homeRoute.path;
        }
        return null;
      },
      routes: [
        AuthRoutes.loginrouter(),
        AuthRoutes.signUprouter(),
      ],
      builder: (context, state) {
        return LayoutOne(
          title: 'WELCOME',
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "WELCOME TO QUICK TASKS MANAGER",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.goNamed(AuthRoutes.loginRoute.name);
                  },
                  child: const Text("Login"),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.goNamed(AuthRoutes.signUpRoute.name);
                  },
                  child: const Text("SignUp"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
