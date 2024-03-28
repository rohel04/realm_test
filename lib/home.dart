import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm_mongo/bloc/todo_bloc.dart';
import 'package:realm_mongo/model/todo.dart';
import 'package:realm_mongo/pages/add_notes.dart';
import 'package:realm_mongo/pages/add_todo.dart';
import 'package:realm_mongo/pages/login.dart';
import 'package:realm_mongo/pages/my_profile.dart';
import 'package:realm_mongo/services/realm_config.dart';
import 'package:realm_mongo/utils/ui_hepler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<TodoBloc>().add(GetTodos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo using Realm'),
        actions: [
          IconButton(
              onPressed: () async {
                await RealmConfig.instance.app.currentUser!.logOut();
                _logoutNavigation();
              },
              icon: const Icon(Icons.logout)),
          IconButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyProfilePage()));
              },
              icon: const Icon(Icons.person))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            TextFormField(
              controller: context.read<TodoBloc>().searchController,
              onChanged: (value) {
                context.read<TodoBloc>().add(SearchTodo(text: value));
              },
              decoration: const InputDecoration(
                  label: Text('Search'),
                  border: OutlineInputBorder(borderSide: BorderSide())),
            ),
            Expanded(
              child:
                  BlocConsumer<TodoBloc, TodoState>(listener: (context, state) {
                if (state.status == TodoOrverViewStatus.failure) {
                  UiHelper.showSnachBar(context, state.errorMessage);
                }
              }, builder: (context, state) {
                if (state.status == TodoOrverViewStatus.loading) {
                  return const CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.black);
                }
                if (state.status == TodoOrverViewStatus.success ||
                    state.status == TodoOrverViewStatus.failure) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListView.separated(
                      itemCount: state.todos.length,
                      itemBuilder: (context, index) {
                        var todo = state.todos[index];
                        return Container(
                          color: Colors.grey.shade200,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: InkWell(
                                  onTap: () => _addTodoNavigation(todo),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        todo.title,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(todo.description),
                                    ],
                                  ),
                                )),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddNotes(todo: todo)));
                                    },
                                    icon: const Icon(
                                      Icons.notes,
                                      color: Colors.orangeAccent,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      context
                                          .read<TodoBloc>()
                                          .add(DeleteTodo(todo: todo));
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ]),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(
                        height: 10,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _addTodoNavigation(null)),
    );
  }

  _logoutNavigation() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  _addTodoNavigation(TodoModel? todo) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddTodoPage(
                  todo: todo,
                )));
  }
}
