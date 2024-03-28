part of 'todo_bloc.dart';

class TodoEvent {}

class SearchTodo extends TodoEvent {
  final String text;

  SearchTodo({required this.text});
}

class GetTodos extends TodoEvent {}

class DeleteTodo extends TodoEvent {
  final TodoModel todo;

  DeleteTodo({required this.todo});
}

class AddTodo extends TodoEvent {
  final TodoModel todo;

  AddTodo({required this.todo});
}

class UpdateTodo extends TodoEvent {
  final TodoModel todo;
  final String title;
  final String description;

  UpdateTodo(
      {required this.todo, required this.title, required this.description});
}
