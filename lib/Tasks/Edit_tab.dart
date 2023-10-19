import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/app_config_provider.dart';
import '../Providers/provider_list.dart';
import '../Theme/MyCustomTheme.dart';
import '../firebase_utils.dart';
import 'TaskDataClass.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Edit_tab extends StatefulWidget{
  static const String routeName = "Edit_tab";

  @override
  State<Edit_tab> createState() => _Edit_tabState();
}

class _Edit_tabState extends State<Edit_tab> {
  late provider_list listprovider;
  DateTime? selectedDate;
  bool dateIsNotChanged = true;


  String newFormattedDate ='';
  String newTitle ='TEST' ;
  String newDescription='TEST';
  String newDate='TEST';

  @override
  Widget build(BuildContext context) {
    listprovider= Provider.of<provider_list>(context);
    var args = ModalRoute.of(context)?.settings.arguments as Task;
    final provider = Provider.of<provider_config>(context);
    return Scaffold(
        appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.app_title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: MyCustomTheme.whiteColor))),
        body: Padding(
          padding: const EdgeInsets.all(35),
          child: Container(
            decoration: BoxDecoration(
              color: provider.appTheme == ThemeMode.dark ? MyCustomTheme.darkContainerColor : MyCustomTheme.whiteColor,
              borderRadius: BorderRadiusDirectional.circular(10)
            ),
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(AppLocalizations.of(context)!.editTask,style: Theme.of(context).textTheme.titleMedium,textAlign: TextAlign.center,),

                  const SizedBox(height: 30,),

                  TextFormField(decoration: InputDecoration(hintText: args.taskTitle,hintStyle: Theme.of(context).textTheme.titleSmall ),onChanged:(value){
                    args.taskTitle=value;
                  } ),

                  TextFormField(decoration: InputDecoration(hintText: args.taskDescription,hintStyle: Theme.of(context).textTheme.titleSmall ),maxLines: 4,onChanged:(value){
                    args.taskDescription=value;
                  }),

                  const SizedBox(height: 30),

                  InkWell(child: Text(DateFormat('yyyy-MM-dd').format(args.date!),
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center),

                      onTap:() async {
                    var pickedDate = await showCalendar();
                    setState(() {
                      args.date = pickedDate;
                      dateIsNotChanged = false; /// dateIsNotSelected false means that the formattedDate is carrying the date in form of yyyy-MM-dd.
                    }
                    );}),
                  Expanded(child: Center(child: ElevatedButton(onPressed:(){
                    FirebaseUtils.updateTask(args).
                    timeout(const Duration(milliseconds: 0),onTimeout: (){
                      listprovider.getAllTasksFromFireStore();
                    });
                    Navigator.of(context).pop();}, child: Text(AppLocalizations.of(context)!.saveButton)))),
                ],
              ),
            ),
          ),
        ));
  }

  Future<DateTime?> showCalendar() async{
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365))
    );
  }
}