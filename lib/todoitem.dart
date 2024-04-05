import 'package:flutter/material.dart';

import 'package:todo_app/model/todo.dart';

class todoitem extends StatefulWidget {
  const todoitem({super.key, required this.task});
  final Todo task;

  @override
  State<todoitem> createState() => _todoitemState();
}

class _todoitemState extends State<todoitem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.task.completed! ? Colors.grey : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /*
            widget.task.type == TaskType.note
                ? Image.asset("lib/assets/images/Category_1.png")
                : widget.task.type == TaskType.contest
                    ? Image.asset("lib/assets/images/Category_2.png")
                    : Image.asset("lib/assets/images/Category_3.png"),
                    */
            Image.asset("lib/assets/images/Category_1.png"),
            Expanded(
              child: Column(
                children: [
                  Text(
                    widget.task.todo!,
                    style: TextStyle(
                      decoration: widget.task.completed!
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "User: ${widget.task.userId!}",
                    style: TextStyle(
                      decoration: widget.task.completed!
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
            Checkbox(
              value: isChecked,
              onChanged: (val) => {
                setState(
                  () {
                    widget.task.completed = !widget.task.completed!;
                    isChecked = val!;
                  },
                )
              },
            ),
          ],
        ),
      ),
    );
  }
}
