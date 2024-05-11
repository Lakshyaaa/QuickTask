part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {
  final List<dynamic>? taskList;

  const TaskInitial({this.taskList});
}

final class ShowTaskDialog extends TaskState {}

final class BekarState extends TaskState {}

final class TaskAdded extends TaskState {
  final bool status;
  final String message;

  const TaskAdded({
    required this.status,
    required this.message,
  });
}
