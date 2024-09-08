import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<String> _todoItems = []; // List of tasks
  final TextEditingController _textFieldController = TextEditingController(); // Controller for input field

  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _todoItems.add(task); // Add task to the list
      });
      _textFieldController.clear(); // Clear input after adding
    }
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index); // Remove task from the list
    });
  }

  Widget _buildTodoItem(String todoText, int index) {
    return ListTile(
      title: Text(todoText),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => _removeTodoItem(index),
      ),
    );
  }

  Widget _buildEmptyMessage() {
    return Center(
      child: Text(
        'No tasks yet. Add a task!',
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  void _showAddTodoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new task'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Enter task here'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                _addTodoItem(_textFieldController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: _todoItems.isEmpty
          ? _buildEmptyMessage() // Show message if the list is empty
          : ListView.builder(
              itemCount: _todoItems.length,
              itemBuilder: (context, index) {
                return _buildTodoItem(_todoItems[index], index);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoDialog,
        tooltip: 'Add task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
