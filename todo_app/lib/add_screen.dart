import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Create task'),
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
        label: Text('Submit'),
        icon: Icon(Icons.send),
        onPressed: () => Navigator.of(context).pop(),
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
