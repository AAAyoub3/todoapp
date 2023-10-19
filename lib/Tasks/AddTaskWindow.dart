import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Theme/MyCustomTheme.dart';
import '../Providers/app_config_provider.dart';
import '../Providers/provider_list.dart';
import '../firebase_utils.dart';
import 'TaskDataClass.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskWindow extends StatefulWidget {
  @override
  State<AddTaskWindow> createState() => _AddTaskWindowState();
}

class _AddTaskWindowState extends State<AddTaskWindow> {
  final formKey = GlobalKey<FormState>();

  final fieldText1 = TextEditingController();
  final fieldText2 = TextEditingController();

  String? taskText;
  String? descriptionText;

  DateTime? selectedDate;
  late String formattedDate;
  String dateErrorMessage = '';
  bool dateIsNotSelected = true;

  late provider_list listprovider;

  @override
  Widget build(BuildContext context) {
    listprovider= Provider.of<provider_list>(context);
    final provider = Provider.of<provider_config>(context);
    return Container(
      decoration: BoxDecoration(color: provider.appTheme == ThemeMode.dark ? MyCustomTheme.darkBodyColor : MyCustomTheme.whiteColor),
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(AppLocalizations.of(context)!.add_title,style: Theme.of(context).textTheme.titleMedium,textAlign: TextAlign.center,),
            const SizedBox(height: 30,),
            TextFormField(decoration: InputDecoration(hintText: AppLocalizations.of(context)!.addHint_title,hintStyle: Theme.of(context).textTheme.titleSmall ),
                onChanged: (value) {
                  taskText=value;
                },controller: fieldText1,
                  validator: TextValidation),
            TextFormField(decoration: InputDecoration(hintText: AppLocalizations.of(context)!.addDesc_title,hintStyle: Theme.of(context).textTheme.titleSmall),maxLines: 4,
                onChanged: (value) {
                  descriptionText=value;
                },controller: fieldText2,
                  validator: TextValidation),
            const SizedBox(height: 30),
            InkWell(child: Text(selectedDate == null ?
            AppLocalizations.of(context)!.selectDate :
            formattedDate,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center), onTap:() async {
                var pickedDate = await showCalendar();
                setState(() {
                  selectedDate = pickedDate;
                  formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
                  dateIsNotSelected = false; /// dateIsNotSelected false means that the formattedDate is carrying the date in form of yyyy-MM-dd.
                    }
                  );}),

          if(dateIsNotSelected) /// Error Message if the date is not selected
          Text(dateErrorMessage , style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.red),textAlign: TextAlign.center,),

          Expanded(child: Center(child: ElevatedButton(onPressed: validateThenAdd, child:  Text(AppLocalizations.of(context)!.addButton)))),
          ],
        ),
      ),
    );
  }

  void validateThenAdd(){
    if(formKey.currentState!.validate() && !dateIsNotSelected){
      FirebaseUtils.addTaskToFireStore(Task(taskTitle: taskText, taskDescription: descriptionText,date: selectedDate)).
      timeout(const Duration(milliseconds: 0),onTimeout: (){
        _showMyDialog(context);
        listprovider.getAllTasksFromFireStore();
      });
    }
    else{
      setState(() {
        dateErrorMessage = AppLocalizations.of(context)!.errorDate;
      });
    }
  }

  String? TextValidation(String? text){
    if (text!.isEmpty){
      return AppLocalizations.of(context)!.emptyField;
    }
    else {
      return null; // There is a text in task or description
    }
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

Future<void> _showMyDialog(BuildContext preContext) async {
  return showDialog<void>(
    context: preContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      var provider = Provider.of<provider_config>(context);
      return AlertDialog(
        content: Text(AppLocalizations.of(context)!.successful_add,
            style: TextStyle(color: provider.appTheme == ThemeMode.dark ? MyCustomTheme.whiteColor : MyCustomTheme.blackColor)),
        backgroundColor: provider.appTheme == ThemeMode.dark ? MyCustomTheme.darkContainerColor : MyCustomTheme.whiteColor,
        actions: <Widget>[
          TextButton(
            child: Text(AppLocalizations.of(context)!.okButton),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(preContext).pop();
            },
          ),
        ],
      );
    },
  );
}

