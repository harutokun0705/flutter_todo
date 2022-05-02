// import 'dart:ffi';

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
class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class Task {
  String text;
  bool isDone;
  Task(this.text, this.isDone);
}

class _TodoListPageState extends State<TodoListPage> {
  List todoList = [];
  String _text = '';
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ToDo')),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                leading: Checkbox(
                  value: todoList[index]["isDone"],
                  onChanged: (bool? value) {
                    setState(() {
                      todoList[index]["isDone"] = value!;
                    });
                  },
                ),
                title: Text(todoList[index]["text"]),
                trailing: Wrap(
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete_forever_sharp),
                      color: Colors.blue,
                      onPressed: () {
                        print("delete");
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("このタスクを削除しますか？"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          todoList.removeAt(index);
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text('削除'))
                                ],
                              );
                            });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.create_sharp),
                      color: Colors.blue,
                      onPressed: () {
                        print("edit");
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("タスク名を変更する"),
                                actions: [
                                  TextField(
                                    onChanged: (String value) {
                                      setState(() {
                                        _text = value;
                                      });
                                      print(_text);
                                      print(index);
                                      print(todoList[index]);
                                    },
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        print(_text);
                                        // setState(() {
                                        //   print("push");
                                        // });
                                        setState(() {
                                          todoList[index]["text"] = _text;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text('変更する'))
                                ],
                              );
                            });
                      },
                    )
                  ],
                )),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return TodoAddPage();
            }),
          );
          if (newListText != null) {
            // キャンセルした場合は newListText が null となるので注意
            setState(() {
              // リスト追加
              todoList.add(newListText);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoAddPage extends StatefulWidget {
  const TodoAddPage({Key? key}) : super(key: key);

  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

// リスト追加Widget
class _TodoAddPageState extends State<TodoAddPage> {
  String _text = '';
  bool isDisabled = true;
  // List tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト追加'),
      ),
      body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_text, style: TextStyle(color: Colors.blue)),
            SizedBox(height: 8),
            TextFormField(
              onChanged: (String value) {
                setState(() {
                  _text = value;
                  if (value.isNotEmpty) {
                    isDisabled = false;
                    return;
                  } else {
                    isDisabled = true;
                    return;
                  }
                });
              },
              maxLength: 25,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return value!.isEmpty ? "文字を入力してください" : null;
              },
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      isDisabled ? Colors.grey : Colors.blue),
                ),
                onPressed: isDisabled
                    ? null
                    : () {
                        Map newItem = {"text": _text, "isDone": false};
                        print(newItem);
                        // tasks.add(newItem);
                        // tasks.insert(0, newItem);
                        // print(tasks);
                        Navigator.of(context).pop(newItem);
                      },
                child: Text('リスト追加', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // キャンセルボタン
              child: TextButton(
                // ボタンをクリックした時の処理
                onPressed: () {
                  // "pop"で前の画面に戻る
                  Navigator.of(context).pop();
                },
                child: Text('キャンセル'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
