import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Providers/provider_list.dart';
import '../Providers/app_config_provider.dart';
import '../Theme/MyCustomTheme.dart';

class CalendarTimeLine extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<provider_config>(context);
    final listProvider = Provider.of<provider_list>(context);
    return CalendarTimeline(
      initialDate:  listProvider.selectDate,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
      onDateSelected: (date){
        listProvider.changeSelectedDate(date);
      },
      leftMargin: 20,
      monthColor: provider.appTheme == ThemeMode.dark ? MyCustomTheme.whiteColor : MyCustomTheme.blackColor,
      dayColor: provider.appTheme == ThemeMode.dark ? MyCustomTheme.whiteColor : MyCustomTheme.blackColor,
      activeDayColor: provider.appTheme == ThemeMode.dark ? MyCustomTheme.blackColor : MyCustomTheme.whiteColor,
      activeBackgroundDayColor: MyCustomTheme.primaryColor,
      dotsColor: MyCustomTheme.whiteColor,
      selectableDayPredicate: (date) => true,
      locale: 'en_ISO',
    );
  }
}