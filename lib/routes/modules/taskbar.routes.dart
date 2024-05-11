import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_task/layout/screen1_layout.dart';
import 'package:quick_task/modules/home/func/task/task_bloc.dart';

import '../../modules/modules.dart' as module;
import '../router.dart';

class TaskListRoutes {
  static final homeRoute = DynamicRoutes(
    name: 'Home Page',
    path: '/home',
  );

  static GoRoute loginrouter() {
    return GoRoute(
      name: homeRoute.name,
      path: homeRoute.path,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => TaskBloc(),
          child: const LayoutOne(
            title: "QuickTask Manager",
            logout: true,
            child: module.HomePage(),
          ),
        );
      },
    );
  }
}
