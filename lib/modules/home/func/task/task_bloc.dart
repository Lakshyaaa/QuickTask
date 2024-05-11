import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskInitial()) {
    on<TaskEvent>((event, emit) {});

    on<AddTaskScreen>(addTaskDialog);

    on<AddTaskData>(addTask);

    on<GetAllTask>(getAllTask);

    on<UpdateTask>(updateTask);

    on<DeleteTask>(deleteTask);
  }

  deleteTask(DeleteTask event, emit) async {
    final current = state;
    if (current is TaskInitial && current.taskList != null) {
      final list = current.taskList!;
      list.removeWhere((element) => element.objectId == event.objectId);
      emit(TaskInitial(
        taskList: list,
      ));
    }
    ParseObject firstObject = ParseObject('TASKS');
    firstObject
      ..objectId = event.objectId
      ..delete();
    final res = await firstObject.save();
    if (res.success) {
      emit(
          TaskAdded(status: res.success, message: 'Task Updated Successfully'));
    } else {
      emit(TaskAdded(status: res.success, message: res.error?.message ?? ""));
    }
    emit(current);
  }

  updateTask(UpdateTask event, emit) async {
    final current = state;
    ParseObject firstObject = ParseObject('TASKS');
    firstObject
      ..objectId = event.objectId
      ..set('status', event.status);
    final res = await firstObject.save();
    if (res.success) {
      emit(
          TaskAdded(status: res.success, message: 'Task Updated Successfully'));
    } else {
      emit(TaskAdded(status: res.success, message: res.error?.message ?? ""));
    }
    emit(current);
  }

  getAllTask(GetAllTask event, emit) async {
    final current = state;
    emit(BekarState());
    ParseObject firstObject = ParseObject('TASKS');
    final QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(firstObject);
    parseQuery.whereContains('user', event.userId);
    final ParseResponse apiResponse = await parseQuery.query();
    if (apiResponse.success && apiResponse.results != null) {
      emit(TaskInitial(taskList: apiResponse.results));
    } else {
      emit(current);
    }
  }

  addTask(AddTaskData event, emit) async {
    final current = state;
    ParseObject firstObject = ParseObject('TASKS');
    firstObject
      ..set('user', event.userId)
      ..set('title', event.title)
      ..set('dueDate', event.dueDate)
      ..set('status', event.status);
    final res = await firstObject.save();
    if (res.success) {
      emit(TaskAdded(status: res.success, message: 'Task Added Successfully'));
    } else {
      emit(TaskAdded(status: res.success, message: res.error?.message ?? ""));
    }
    emit(current);
  }

  addTaskDialog(AddTaskScreen event, emit) {
    final current = state;
    emit(ShowTaskDialog());
    emit(current);
  }
}
