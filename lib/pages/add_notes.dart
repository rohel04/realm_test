import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_mongo/model/notes.dart';
import 'package:realm_mongo/model/todo.dart';
import 'package:realm_mongo/services/notes_services.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key, required this.todo});

  final TodoModel todo;

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final _notesController = TextEditingController();
  final NotesServices _notesServices = NotesServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                  label: Text('Notes'),
                  border: OutlineInputBorder(borderSide: BorderSide())),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  var note = Notes(ObjectId(), _notesController.text);
                  _notesServices.addNotesToTodo(widget.todo, note);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10)),
                child: const Text('Add'))
          ],
        ),
      ),
    );
  }
}
