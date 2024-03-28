import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realm/realm.dart';
import 'package:realm_mongo/model/todo.dart';
import 'package:realm_mongo/services/todo_services.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<TodoEvent>((event, emit) {});
    on<SearchTodo>(_searchTodo);
    on<GetTodos>(_getTodos);
    on<DeleteTodo>(_deleteTodo);
    on<AddTodo>(_addTodo);
    on<UpdateTodo>(_updateTodo);
  }

  final TodoServices _todoServices = TodoServices();
  final searchController = TextEditingController();
  final String unknownError = "Something went wrong";

  Future<void> _searchTodo(SearchTodo event, Emitter<TodoState> emit) async {
    try {
      emit(state.copyWith(
          status: TodoOrverViewStatus.loading, errorMessage: ''));
      var todos = _todoServices.searchTodo(event.text);
      emit(state.copyWith(
          status: TodoOrverViewStatus.success, todos: todos, errorMessage: ''));
    } on RealmException catch (e) {
      emit(state.copyWith(
          status: TodoOrverViewStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          status: TodoOrverViewStatus.failure, errorMessage: unknownError));
    }
  }

  Future<void> _getTodos(GetTodos event, Emitter<TodoState> emit) async {
    try {
      emit(state.copyWith(
          status: TodoOrverViewStatus.loading, errorMessage: ''));
      var todos = _todoServices.getTodos();
      emit(state.copyWith(
          status: TodoOrverViewStatus.success, todos: todos, errorMessage: ''));
    } on RealmException catch (e) {
      emit(state.copyWith(
          status: TodoOrverViewStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          status: TodoOrverViewStatus.failure, errorMessage: unknownError));
    }
  }

  Future<void> _deleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    try {
      emit(state.copyWith(
          status: TodoOrverViewStatus.loading, errorMessage: ''));
      _todoServices.deleteTodo(event.todo);
      add(SearchTodo(text: searchController.text));
    } on RealmException catch (e) {
      emit(state.copyWith(
          status: TodoOrverViewStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          status: TodoOrverViewStatus.failure, errorMessage: unknownError));
    }
  }

  Future<void> _addTodo(AddTodo event, Emitter<TodoState> emit) async {
    try {
      _todoServices.addTodo(event.todo);
      add(SearchTodo(text: searchController.text));
    } on RealmException catch (e) {
      emit(state.copyWith(
          status: TodoOrverViewStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          status: TodoOrverViewStatus.failure, errorMessage: unknownError));
    }
  }

  Future<void> _updateTodo(UpdateTodo event, Emitter<TodoState> emit) async {
    try {
      _todoServices.updateTodo(event.todo, event.title, event.description);
      add(SearchTodo(text: searchController.text));
    } on RealmException catch (e) {
      emit(state.copyWith(
          status: TodoOrverViewStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          status: TodoOrverViewStatus.failure, errorMessage: unknownError));
    }
  }
}
