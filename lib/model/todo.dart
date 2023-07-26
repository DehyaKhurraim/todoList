class ToDo {
  String id;
  String task;
  bool isDone;

  ToDo({
    required this.id,
    required this.task,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', task: 'Wake up at 7:00 am', isDone: true),
      ToDo(id: '02', task: 'Go for jogging', isDone: true),
      ToDo(id: '03', task: 'Check emails'),
      ToDo(id: '04', task: 'Work on mobile apps ', isDone: true),
      ToDo(id: '05', task: 'Attend Meeting'),
      ToDo(id: '06', task: 'Go for Shopping'),
    ];
  }
}
