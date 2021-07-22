import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'task_notifier.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);
    return Scaffold(
      appBar: AppBar(
        title: Text('Update task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Complete todo app',
              ),
            ),
            SizedBox(height: 20),
            Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextFormField(
              controller: descriptionController,
              maxLines: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: hintText,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Update'),
        icon: Icon(Icons.send),
        onPressed: () {
          final updatedTask = task.copyWith(
            title: titleController.text,
            description: descriptionController.text,
          );
          Provider.of<TaskNotifer>(context, listen: false)
              .updateTask(updatedTask);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

final hintText = '''
Create an add task screen.
Create a read task screen.
Create a delete dialog.
Create an edit task screen.
''';
