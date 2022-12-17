import 'package:flutter/material.dart';
import 'package:sample_project/task_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TaskItemModel> tasks = [TaskItemModel("Hello ", "", DateTime.now(), false)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade200,
        body: SizedBox.expand(
          child: Stack(
            children: [
              Image.asset("assets/sky.jpeg"),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Task Manager",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Text("December 19",
                        style: TextStyle(
                            color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 56, 39, 39),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: tasks
                              .map((e) => TaskItem(
                                    task: e,
                                    onChange: (bool value) {
                                      setState(() {
                                        tasks
                                            .firstWhere((elm) => elm.title == e.title)
                                            .isCompleted = value;
                                      });
                                    },
                                  ))
                              .toList()
                              .where((element) => !element.task.isCompleted)
                              .toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text("Completed"),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15), color: Colors.white),
                        child: Column(
                          children: tasks
                              .map((e) => TaskItem(
                                    task: e,
                                    onChange: (bool value) {
                                      setState(() {
                                        tasks
                                            .firstWhere((elm) => elm.title == e.title)
                                            .isCompleted = value;
                                      });
                                    },
                                  ))
                              .toList()
                              .where((element) => element.task.isCompleted)
                              .toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              tasks.add(TaskItemModel("new task", "", DateTime.now(), false));
                            });
                          },
                          child: Text("Add Task"),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue.shade700, foregroundColor: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class TaskItem extends StatefulWidget {
  final TaskItemModel task;

  final void Function(bool value) onChange;

  const TaskItem({
    Key? key,
    required this.task,
    required this.onChange,
  }) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.task.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.green,
            child: Icon(Icons.place),
          ),
          SizedBox(width: 10),
          Text(
              "${widget.task.title}  ${widget.task.timestamp.hour}:${widget.task.timestamp.minute}"),
          Spacer(),
          Checkbox(
              value: widget.task.isCompleted,
              onChanged: (bool? value) {
                widget.onChange(value ?? false);
              })
        ],
      ),
    );
  }
}
