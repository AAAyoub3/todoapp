import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/app_config_provider.dart';
import '../Tasks/Edit_tab.dart';
import '../Settings/settings_tab.dart';
import '../Tasks/AddTaskWindow.dart';
import '../Tasks/TaskDataClass.dart';
import '../Tasks/Tasks_List_tab.dart';
import '../Theme/MyCustomTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home_screen extends StatefulWidget {
  static const String routeName = 'Home_screen';

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  List<Task> tasks = [];
  List<Widget> tabs = [Tasks_List_tab(), settings_tab()];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<provider_config>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.app_title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: MyCustomTheme.whiteColor))),
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Theme(data: Theme.of(context).copyWith(canvasColor: provider.appTheme == ThemeMode.dark ? MyCustomTheme.darkBodyColor : MyCustomTheme.whiteColor),
          child: BottomNavigationBar(
            backgroundColor: provider.appTheme == ThemeMode.dark ? MyCustomTheme.darkBodyColor : MyCustomTheme.whiteColor,
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            elevation: 0.0,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {addNewItem();},
        shape: StadiumBorder(
            side: BorderSide(
          color: MyCustomTheme.whiteColor,
          width: 4,
        )),
        child: const Icon(Icons.add, size: 30,),
      ),
    );
  }
  void addNewItem() {
    showModalBottomSheet(
        context: context, builder:(context)=> AddTaskWindow());
  }
}
