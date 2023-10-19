class Task{
  String? id;
  String? taskTitle;
  String? taskDescription;
  DateTime? date;
  bool? isDone;

  Task({
    this.id='',
    required this.taskTitle,
    required this.taskDescription,
    required this.date,
    this.isDone=false
  });

  Task.fromFireStore(Map<String,dynamic> data):this(
      id: data["id"],
      taskTitle: data["taskTitle"],
      taskDescription:data["taskDescription"] ,
      date: DateTime.fromMillisecondsSinceEpoch(data["date"]),
      isDone:data["isDone"]
  );

  Map<String,dynamic> toFireStore(){
    return{
      "id": id,
      "taskTitle" : taskTitle,
      "taskDescription" : taskDescription,
      "date": date?.millisecondsSinceEpoch,
      "isDone" : isDone
    };
  }
}
