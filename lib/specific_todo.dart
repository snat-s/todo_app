import 'package:flutter/material.dart';

class SpecificTodo extends StatelessWidget {
  final String todo;
  final bool isDone;
  final int index;

  const SpecificTodo(
      {super.key,
      required this.todo,
      required this.isDone,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Viewing: $index'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Text(
            todo,
            style: TextStyle(
              decoration: isDone ? TextDecoration.lineThrough : null,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
