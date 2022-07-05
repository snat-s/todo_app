import 'package:flutter/material.dart';

class ListAll extends StatelessWidget {
  const ListAll({super.key, required this.listOfTasks, required this.title});
  final Set<String> listOfTasks;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: listOfTasks.isEmpty
          ? const Center(
              child: Text(
                'Wow such empty',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(10),
              children: listOfTasks.map((text) {
                return ListTile(title: Text(text));
              }).toList(),
            ),
    );
  }
}
