// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class AddTaskScreen extends TaskEvent {}

class GetAllTask extends TaskEvent {
  final String userId;

  const GetAllTask({
    required this.userId,
  });
}

class DeleteTask extends TaskEvent {
  final String objectId;

  const DeleteTask({
    required this.objectId,
  });
}

class UpdateTask extends TaskEvent {
  final String objectId;
  final bool status;
  const UpdateTask({
    required this.objectId,
    required this.status,
  });
}

class AddTaskData extends TaskEvent {
  final String title;
  final String dueDate;
  final String userId;
  final bool status;

  const AddTaskData({
    required this.title,
    required this.dueDate,
    required this.userId,
    this.status = false,
  });
}
