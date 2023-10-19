import 'package:cloud_firestore/cloud_firestore.dart';
import '../Tasks/TaskDataClass.dart';

class FirebaseUtils{

  static CollectionReference<Task> getTasksCollection(){
    return  FirebaseFirestore.instance.collection('tasks').
    withConverter<Task>(
        fromFirestore: (snapshot, options) => Task.fromFireStore(snapshot.data()!),
        toFirestore: (task, options) => task.toFireStore()
    );
  }

  static Future<void> addTaskToFireStore(Task task){
    var tasksCollection = getTasksCollection();
    var docRef = tasksCollection.doc(); /// if you didn't write document id then he will generate it automatically
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(String? id) {
    var tasksCollection = getTasksCollection();
    return tasksCollection.doc(id).delete();
  }

  static Future<void> clearFireStore() async {
    var tasksCollection = getTasksCollection();
    var querySnapshot = await tasksCollection.get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  static Future<void> updateTask(Task task) {
    var tasksCollection = getTasksCollection();
    return tasksCollection.doc(task.id).update({
      "taskTitle" : task.taskTitle,
      "taskDescription" : task.taskDescription,
      "date": task.date?.millisecondsSinceEpoch,
    });
  }
}