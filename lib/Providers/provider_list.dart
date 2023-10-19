import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../Tasks/TaskDataClass.dart';
import '../firebase_utils.dart';

class provider_list extends ChangeNotifier {
  List<Task> taskslist =[];
  DateTime selectDate = DateTime.now();

  void getAllTasksFromFireStore() async{
    QuerySnapshot<Task> querySnapshot = await FirebaseUtils.getTasksCollection().get();
    taskslist =  querySnapshot.docs.map((doc){return doc.data();}).toList();
    taskslist = taskslist.where((task){ /// instead of using for loop on every task
      if(selectDate.day == task.date?.day     &&
         selectDate.month == task.date?.month &&
         selectDate.year == task.date?.year
      ) {
        return true;
      }
      return false;
    }).toList();
    notifyListeners();
  }

  void changeSelectedDate (var newDate){
    selectDate = newDate;
    getAllTasksFromFireStore();
  }
}