import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Providers/app_config_provider.dart';
import '../Tasks/Edit_tab.dart';
import '../Tasks/TaskDataClass.dart';
import '../Providers/provider_list.dart';
import '../Theme/MyCustomTheme.dart';
import '../firebase_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Task_Widget extends StatefulWidget{
  Task task;
  Task_Widget({required this.task});

  @override
  State<Task_Widget> createState() => _Task_WidgetState();
}

class _Task_WidgetState extends State<Task_Widget> {
  late provider_list listprovider;
  @override
  Widget build(BuildContext context) {

      listprovider= Provider.of<provider_list>(context);
      final provider = Provider.of<provider_config>(context);
      return InkWell(
        onTap: (){
          if(widget.task.isDone == false){ /// this condition in order not to make the user tap when it's done
            Navigator.of(context).pushNamed(Edit_tab.routeName,arguments: widget.task);
          }
        },
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio:0.2,
            motion: const ScrollMotion(),
            children:[
              SlidableAction(
                onPressed: (context){
                FirebaseUtils.deleteTaskFromFireStore(widget.task.id).
                timeout(const Duration(milliseconds: 0),onTimeout: (){
                  _showMyDialog(context);
                  listprovider.getAllTasksFromFireStore();
                });
                },
                backgroundColor: MyCustomTheme.redColor,
                foregroundColor: MyCustomTheme.whiteColor,
                icon: Icons.delete,
                label: AppLocalizations.of(context)!.deleteButton,
                borderRadius: BorderRadius.circular(10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: provider.appTheme == ThemeMode.dark ? MyCustomTheme.darkContainerColor : MyCustomTheme.whiteColor,
            ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(decoration: BoxDecoration(
                      color: MyCustomTheme.primaryColor,
                    ),height: 60,width: 3,),
                    Column(
                      children: [
                        Text(widget.task.taskTitle??"",style:Theme.of(context).textTheme.titleMedium?.copyWith(color: widget.task.isDone == true ? MyCustomTheme.greenColor : MyCustomTheme.primaryColor ),),
                        Text(widget.task.taskDescription??"",style:Theme.of(context).textTheme.titleSmall?.copyWith(color: widget.task.isDone == true ? MyCustomTheme.greenColor : MyCustomTheme.primaryColor ),),
                        Row(
                          children: [
                            Icon(Icons.timer,color: provider.appTheme == ThemeMode.dark ? MyCustomTheme.whiteColor : MyCustomTheme.timeColor,size: 15),
                            Text(DateFormat('yyyy-MM-dd').format(widget.task.date!),
                              style:Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: provider.appTheme == ThemeMode.dark ? MyCustomTheme.whiteColor : MyCustomTheme.timeColor,),textAlign: TextAlign.end,),
                          ],
                        ),
                      ],
                    ),
                    if(widget.task.isDone == false)
                    ElevatedButton(onPressed: (){
                      /// ISDONE BUTTON
                      setState(() {
                        widget.task.isDone= true;
                        FirebaseUtils.updateTask(widget.task).
                        timeout(const Duration(milliseconds: 1500),onTimeout: (){
                          FirebaseUtils.deleteTaskFromFireStore(widget.task.id);
                          listprovider.getAllTasksFromFireStore();});
                      });
                    }, child:Icon(Icons.check,size: 30),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(widget.task.isDone == true ? MyCustomTheme.greenColor : MyCustomTheme.primaryColor ),
                          elevation:MaterialStateProperty.all(0.0)),),
                    if(widget.task.isDone == true)
                      Text(AppLocalizations.of(context)!.done,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: MyCustomTheme.greenColor))

                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
}

Future<void> _showMyDialog(BuildContext preContext) async {
  return showDialog<void>(
    context: preContext,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(AppLocalizations.of(context)!.successful_delete),
        actions: <Widget>[
          TextButton(
            child: Text(AppLocalizations.of(context)!.okButton),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

