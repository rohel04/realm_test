part of 'todo_bloc.dart';

enum TodoOrverViewStatus { initial, loading, success, failure }

class TodoState extends Equatable {
  final TodoOrverViewStatus status;
  final List<TodoModel> todos;
  final String errorMessage;

  const TodoState(
      {this.errorMessage = '',
      this.status = TodoOrverViewStatus.initial,
      this.todos = const []});

  TodoState copyWith(
      {TodoOrverViewStatus? status,
      List<TodoModel>? todos,
      String? errorMessage}) {
    return TodoState(
        status: status ?? this.status,
        todos: todos ?? this.todos,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [status, todos];
}
