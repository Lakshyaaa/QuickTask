import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_task/func/auth/auth_bloc.dart';
import 'package:quick_task/modules/home/func/task/task_bloc.dart';
import 'package:quick_task/util/custom_snackbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController title;
  late final TextEditingController dueDate;

  @override
  void initState() {
    title = TextEditingController();
    dueDate = TextEditingController();
    getTask();
    super.initState();
  }

  @override
  void dispose() {
    title.dispose();
    dueDate.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is ShowTaskDialog) {
              showDialog(
                context: context,
                builder: (_) {
                  return BlocProvider.value(
                    value: BlocProvider.of<TaskBloc>(context),
                    child: Dialog(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Add Task',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: title,
                                decoration: const InputDecoration(
                                  labelText: "Title",
                                  hintText: "Enter title",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: dueDate,
                                decoration: const InputDecoration(
                                  labelText: "Due Date",
                                  hintText: "Enter due date",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      final session =
                                          BlocProvider.of<AuthBloc>(context)
                                              .state;
                                      if (session is AuthSession) {
                                        BlocProvider.of<TaskBloc>(context).add(
                                          AddTaskData(
                                            title: title.text,
                                            dueDate: dueDate.text,
                                            userId: session.email,
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text('Add Task'),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        BlocListener<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is TaskAdded) {
              CustomSnackbar.pushSnackbar(
                context,
                state.message,
                error: !state.status,
              );
              if (state.status) {
                title.clear();
                dueDate.clear();
                getTask();
                try {
                  context.pop();
                } catch (e) {
                  if (kDebugMode) {
                    print(e);
                  }
                }
              }
            }
          },
        ),
      ],
      child: BlocBuilder<TaskBloc, TaskState>(
        buildWhen: (previous, current) {
          return current is TaskInitial;
        },
        builder: (context, state) {
          if (state is TaskInitial) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key('item_${state.taskList?[index]['objectId']}'),
                    onDismissed: (direction) {
                      // Add logic to handle item removal
                      if (direction == DismissDirection.endToStart) {
                        BlocProvider.of<TaskBloc>(context).add(
                          DeleteTask(
                            objectId: state.taskList?[index]['objectId'],
                          ),
                        );
                      }
                    },
                    background: Container(
                        color: Colors.red), // Background when swiped left
                    child: ListTile(
                      leading: Checkbox(
                        value: state.taskList?[index]['status'],
                        onChanged: (val) {
                          BlocProvider.of<TaskBloc>(context).add(
                            UpdateTask(
                              objectId: state.taskList?[index]['objectId'],
                              status: val ?? false,
                            ),
                          );
                        },
                      ),
                      title: Text(
                        state.taskList?[index]['title'],
                        style: TextStyle(
                          decoration: state.taskList?[index]['status']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationColor: Colors.red,
                          decorationThickness: 2,
                        ),
                      ),
                      subtitle:
                          Text('Due Date ${state.taskList?[index]['dueDate']}'),
                    ),
                  );

                  // Text(state.taskList?[index]['title']);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemCount: state.taskList?.length ?? 0);
          } else {
            return const Placeholder();
          }
        },
      ),
    );
  }

  void getTask() {
    final session = BlocProvider.of<AuthBloc>(context).state;
    if (session is AuthSession) {
      BlocProvider.of<TaskBloc>(context).add(GetAllTask(userId: session.email));
    }
  }
}
