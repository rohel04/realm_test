// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm/realm.dart';
import 'package:realm_mongo/bloc/todo_bloc.dart';
import 'package:realm_mongo/model/todo.dart';
import 'package:realm_mongo/services/realm_config.dart';
import 'package:realm_mongo/utils/date_time_util.dart';

class AddTodoPage extends StatefulWidget {
  AddTodoPage({super.key, this.todo});
  TodoModel? todo;

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    if (widget.todo != null) {
      _titleController.text = widget.todo!.title;
      _descriptionController.text = widget.todo!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo != null ? 'Update Todo' : 'Add Todo'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                  label: Text('Title'),
                  border: OutlineInputBorder(borderSide: BorderSide())),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                  label: Text('Description'),
                  border: OutlineInputBorder(borderSide: BorderSide())),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  if (widget.todo != null) {
                    context.read<TodoBloc>().add(UpdateTodo(
                        todo: widget.todo!,
                        title: _titleController.text,
                        description: _descriptionController.text));
                  } else {
                    var todo = TodoModel(
                        ObjectId(),
                        _titleController.text,
                        _descriptionController.text,
                        RealmConfig.instance.app.currentUser!.id,
                        metaData: {
                          'createdAt': RealmValue.string(
                              DateTimeUtil.dateAndTimeString(
                                  dateTime: DateTime.now()))
                        });
                    context.read<TodoBloc>().add(AddTodo(todo: todo));
                  }

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10)),
                child: Text(widget.todo != null ? 'Update' : 'Add')),
            const SizedBox(
              height: 20,
            ),
            widget.todo != null
                ? Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Notes for todo',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Flexible(
                            child: ListView.builder(
                                itemCount: widget.todo!.notes.length,
                                itemBuilder: (context, index) {
                                  var note = widget.todo!.notes[index];
                                  return ListTile(
                                    title: Row(
                                      children: [
                                        const Icon(Icons.donut_small),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(note.text),
                                      ],
                                    ),
                                  );
                                }))
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
