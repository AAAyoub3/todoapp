import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Providers/app_config_provider.dart';
import '../Theme/MyCustomTheme.dart';

class theme_sheet_list extends StatefulWidget {


  @override
  State<theme_sheet_list> createState() => _Language_sheet_listState();
}

class _Language_sheet_listState extends State<theme_sheet_list> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<provider_config>(context);
    return Container(
      color: provider.appTheme == ThemeMode.dark ? MyCustomTheme.darkBodyColor : MyCustomTheme.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell( /// light
              onTap: (){
                provider.changeTheme(ThemeMode.light);
              },
              child: provider.appTheme == ThemeMode.light ? getSelectedWidget(AppLocalizations.of(context)!.lightTheme):
              getUnSelectedWidget(AppLocalizations.of(context)!.lightTheme)
          ),



          InkWell( /// dark
              onTap: (){
                provider.changeTheme(ThemeMode.dark);
              },
              child: provider.appTheme == ThemeMode.dark ? getSelectedWidget(AppLocalizations.of(context)!.darkTheme):
              getUnSelectedWidget(AppLocalizations.of(context)!.darkTheme)
          ),
        ],
      ),
    );
  }

  Widget getSelectedWidget(String text){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,style: Theme.of(context).textTheme.titleMedium),
          Icon(Icons.check,color: MyCustomTheme.primaryColor)
        ],
      ),
    );
  }
  Widget getUnSelectedWidget(String text){
    var provider = Provider.of<provider_config>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }

}
