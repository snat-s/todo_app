import 'package:flutter/material.dart';

import 'new_todo.dart';
import 'specific_todo.dart';
import 'list_all.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      home: const Todo(),
    );
  }
}

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final PageController controller = PageController();
  final List<String> _todoTexts = <String>[];
  // so this makes it work to 1000 after that it should break
  final List<bool> _markedDone = List<bool>.filled(1000, false);
  final _todo = <String>{};
  final _done = <String>{};

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Todo App'),
          ),
          body: _todoTexts.isEmpty
              ? const Center(
                  child: Text(
                    'Wow such empty',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: _todoTexts.length, //size.value,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      title: Text(
                        _todoTexts[index],
                        style: TextStyle(
                          decoration: _markedDone[index]
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      onTap: () {
                        _specificTodo(index);
                      },
                      trailing: TextButton(
                        onPressed: () {
                          setState(() {
                            if (!_markedDone[index]) {
                              _todo.remove(_todoTexts[index]);
                              _done.add(_todoTexts[index]);
                            } else {
                              _done.remove(_todoTexts[index]);
                              _todo.add(_todoTexts[index]);
                            }
                            _markedDone[index] = !_markedDone[index];
                          });
                        },
                        child: Icon(
                          _markedDone[index] ? Icons.clear : Icons.check,
                          color: Colors.black,
                        ),
                      ),
                    );
                  })),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Create TODO',
            onPressed: _pushNewTodo,
            backgroundColor: Colors.black,
            child: const Icon(Icons.add),
          ),
        ),
        ListAll(
          listOfTasks: _todo.toList(),
          title: 'TODO',
        ),
        ListAll(listOfTasks: _done.toList(), title: 'DONE'),
      ],
    );
  }

  void _pushNewTodo() async {
    //Make a new Todo
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewTodo()),
    );

    setState(() {
      _todoTexts.add(result);
      _todo.add(result);
    });
  }

  void _specificTodo(index) {
    // View a specific todo
    int i = index + 1;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SpecificTodo(
          todo: _todoTexts[index],
          isDone: _markedDone[index],
          index: i,
        ),
      ),
    );
  }
}
