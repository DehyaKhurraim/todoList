import 'package:flutter/material.dart';
import '../constant/color.dart';
import '../model/todo.dart';
import 'package:todo_list/widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  final todocontroller = TextEditingController();
  List<ToDo> foundtodo = [];

  @override
  void initState() {
    foundtodo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            margin: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                _searchbar(),
                Expanded(
                  child: ListView(
                    children: [
                      _heading(),
                      for (ToDo todoo in foundtodo.reversed)
                        ToDoItem(
                          todo: todoo,
                          onToDoChange: _handelToDo,
                          onDeleteItem: _deleteToDo,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                _addTask(),
                _addtaskBtn(),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handelToDo(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDo(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDo(String todo) {
    setState(() {
      todosList.add(
        ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          task: todo,
        ),
      );
    });
    todocontroller.clear();
  }

  void runFilter(String enteredKey) {
    List<ToDo> result = [];
    if (enteredKey.isEmpty) {
      result = todosList;
    } else {
      result = todosList
          .where((item) =>
              item.task.toLowerCase().contains(enteredKey.toLowerCase()))
          .toList();
    }

    setState(() {
      foundtodo = result;
    });
  }

  Container _addtaskBtn() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
        right: 20,
      ),
      child: ElevatedButton(
        onPressed: () {
          _addToDo(todocontroller.text);
        },
        style: ElevatedButton.styleFrom(
          primary: tdDarkBlue,
          elevation: 10,
        ),
        child: const Text(
          '+',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
      ),
    );
  }

  Expanded _addTask() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 20,
          right: 20,
          left: 20,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: tdBlack,
              offset: Offset(0.0, 0.0),
              blurRadius: 15.0,
              spreadRadius: 0.0,
              blurStyle: BlurStyle.outer,
            ),
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
          onSubmitted: _addToDo,
          controller: todocontroller,
          decoration: const InputDecoration(
            hintText: 'Add a new task',
            hintStyle: TextStyle(
              color: tdGrey,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Container _heading() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 10,
      ),
      child: const Text(
        'All ToDo\'s',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }

  Container _searchbar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (enteredKey) => runFilter(enteredKey),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 35,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
            color: tdBlack,
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdGrey,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBGColor,
            size: 30,
          ),
          Container(
            padding: const EdgeInsets.all(5.0),
            width: 50,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                'images/avatar.jpeg',
              ),
            ),
          )
        ],
      ),
    );
  }
}
