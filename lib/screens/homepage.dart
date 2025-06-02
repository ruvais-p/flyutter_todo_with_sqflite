import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/servieces/database_serviece.dart'; // Renamed file and class

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final DatabaseService _databaseService = DatabaseService.instance;
  List<Task> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() {
      _isLoading = true;
    });

    final tasks = await _databaseService.getTasks();

    setState(() {
      _tasks = tasks;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingButton(),
      appBar: AppBar(
        title: const Text("My ToDo List"),
        centerTitle: true,
      ),
      body: _taskList(),
    );
  }

  Widget _floatingButton() {
    String? task;
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Add Task'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter your task...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) => task = value,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Done"),
                    onPressed: () async {
                      if (task != null && task!.trim().isNotEmpty) {
                        await _databaseService.addTask(task!.trim());
                        Navigator.pop(context);
                        await _loadTasks();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _taskList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_tasks.isEmpty) {
      return const Center(
        child: Text("No tasks yet. Tap + to add one."),
      );
    }

    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return ListTile(
          onLongPress: () async {
            await _databaseService.deleteTask(task.id);
            await _loadTasks();
          },
          title: Text(
            task.content,
            style: TextStyle(
              decoration: task.status == 1
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          trailing: Checkbox(
            value: task.status == 1,
            onChanged: (value) async {
              await _databaseService.updateTaskStatus(task.id, value! ? 1 : 0);
              await _loadTasks();
            },
          ),
        );
      },
    );
  }
}
