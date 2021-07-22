import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/task_notifier.dart';
import 'add_screen.dart';
import 'update_screen.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskNotifer(),
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(primarySwatch: Colors.yellow),
        home: HomeScreen(),
        routes: {
          'add': (_) => AddScreen(),
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TaskNotifer>(context).tasks;
    final deleteTask =
        Provider.of<TaskNotifer>(context, listen: false).deleteTask;
    return Scaffold(
      appBar: AppBar(title: Text('Todo App')),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Card(
              child: ListTile(
                title: Text(task.title),
                leading: Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return UpdateScreen(task: task);
                            },
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Delete task: ${task.title}?'),
                            content: Text('Deleted tasks cannot be recovered.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  deleteTask(task.id);
                                  Navigator.of(context).pop();
                                },
                                child: Text('DELETE'),
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('add'),
        child: Icon(Icons.add),
      ),
    );
  }
}

class Task {
  final String title;
  final String description;
  bool completed;
  final int id;

  Task({
    required this.title,
    required this.description,
    this.completed = false,
    required this.id,
  });

  Task copyWith({
    String? title,
    String? description,
    bool? completed,
    int? id,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      id: id ?? this.id,
    );
  }
}
