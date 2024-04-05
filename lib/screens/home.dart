import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/constants/color.dart';
import 'package:todo_app/constants/tasktype.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/screens/add_newtask.dart';
import 'package:todo_app/service/todo_service.dart';
import 'package:todo_app/todoitem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //List<String> todo = ["Study Lesson", "Runk 5K", "Go to party"];
  //List<String> completed = ["Game meetup", "Take Out Trash"];
  List<Task> todo = [
    Task(
      type: TaskType.note,
      title: "Study Lesson",
      description: "Study COMP117",
      isCompleted: false,
    ),
    Task(
      type: TaskType.contest,
      title: "Go to party",
      description: "Attend to party",
      isCompleted: false,
    ),
    Task(
      type: TaskType.calender,
      title: "Run 5K",
      description: "Run 5 kilometers",
      isCompleted: false,
    ),
  ];

  List<Task> completed = [
    Task(
      type: TaskType.contest,
      title: "Go to party",
      description: "Attend to party",
      isCompleted: false,
    ),
    Task(
      type: TaskType.calender,
      title: "Run 5K",
      description: "Run 5 kilometers",
      isCompleted: false,
    ),
  ];

  void addNewTask(Task newTask) {
    setState(() {
      todo.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    TodoService todoService = TodoService();

    double deviceWidht = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: HexColor(backgroundcolor),
          body: Column(
            children: [
              // header
              Container(
                decoration: const BoxDecoration(
                    color: Colors.purple,
                    image: DecorationImage(
                      image: AssetImage("lib/assets/images/Header.png"),
                      fit: BoxFit.cover,
                    )),
                width: deviceWidht,
                height: deviceHeight / 3,
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "March 23, 2024",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        "My Todo List",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              // top column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SingleChildScrollView(
                    child: FutureBuilder(
                      future: todoService.getUncompletedTodos(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const CircularProgressIndicator();
                        } else {
                          return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return todoitem(
                                task: snapshot.data![index],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              // completed text
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Completed",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // bottom column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SingleChildScrollView(
                    child: FutureBuilder(
                      future: todoService.getCompletedTodos(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const CircularProgressIndicator();
                        } else {
                          return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return todoitem(
                                task: snapshot.data![index],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddNewTaskScreen(
                      addNewTask: (newTask) => addNewTask(newTask),
                    ),
                  ));
                },
                child: const Text("Add New Task"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
