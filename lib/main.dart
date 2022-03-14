import 'package:flutter/material.dart';

void main() {
  runApp(MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
    );
  }
}

// リスト一覧Widget
class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('リスト一覧画面'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return TodoAddPage();
            }),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// リスト追加Widget
class TodoAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('リスト追加画面'),
      )),
    );
  }
}
