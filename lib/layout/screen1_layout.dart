// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_task/func/auth/auth_bloc.dart';
import 'package:quick_task/modules/home/func/task/task_bloc.dart';
import 'package:quick_task/routes/router.dart';

class LayoutOne extends StatelessWidget {
  final Widget child;
  final String title;
  final bool logout;
  const LayoutOne({
    Key? key,
    required this.child,
    required this.title,
    this.logout = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          if (logout)
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthInitial) {
                  context.goNamed(Routes.startPage.name);
                }
              },
              child: IconButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
                },
                icon: const Icon(
                  Icons.exit_to_app_rounded,
                ),
              ),
            ),
        ],
      ),
      body: child,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          BlocProvider.of<TaskBloc>(context).add(AddTaskScreen());
        },
      ),
    );
  }
}
