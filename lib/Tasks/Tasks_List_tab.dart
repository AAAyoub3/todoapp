import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/provider_list.dart';
import '../Tasks/CalenderTimeLine.dart';
import '../Tasks/Task_Widget.dart';

class Tasks_List_tab extends StatefulWidget{
  static const String routeName = 'Task_Tab';
  @override
  State<Tasks_List_tab> createState() => _Tasks_List_tabState();
}

class _Tasks_List_tabState extends State<Tasks_List_tab> {
  @override
  Widget build(BuildContext context) {
    var listprovider= Provider.of<provider_list>(context);
    if(listprovider.taskslist.isEmpty){
      listprovider.getAllTasksFromFireStore();
    }
    return Column(
      children: [
        CalendarTimeLine(),

        const SizedBox(height: 10),

        Expanded(
          child: ListView.builder(itemBuilder:(context,index){
            return Task_Widget(task: listprovider.taskslist[index]);}
              ,itemCount: listprovider.taskslist.length),
        ),
      ],
    );
  }
}
