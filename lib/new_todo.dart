import 'package:flutter/material.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({super.key});

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  TextEditingController controller = TextEditingController();
  List<String> allStrings = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Todo',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'New TODO',
              suffixIcon: IconButton(
                onPressed: controller.clear,
                icon: const Icon(Icons.clear),
              ),
            ),
            controller: controller,
            onSubmitted: (String value) {
              setState(() {
                allStrings.add(value);
                Navigator.pop(context, value);
                controller.clear();
              });
            },
          ),
        ),
      ),
    );
  }
}
