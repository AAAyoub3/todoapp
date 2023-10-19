import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Providers/app_config_provider.dart';
import '../Theme/MyCustomTheme.dart';

class Language_sheet_list extends StatefulWidget {


  @override
  State<Language_sheet_list> createState() => _Language_sheet_listState();
}

class _Language_sheet_listState extends State<Language_sheet_list> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<provider_config>(context);
    return Container(
      color: provider.appTheme == ThemeMode.dark ? MyCustomTheme.darkBodyColor : MyCustomTheme.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: (){
                provider.changeLanguage("ar");
              },
              child: provider.appLanguage == 'ar' ? getSelectedItemWidget(AppLocalizations.of(context)!.arabic):
              getUnSelectedItemWidget(AppLocalizations.of(context)!.arabic)
          ),





          InkWell(
              onTap: (){
                provider.changeLanguage("en");
              },
              child: provider.appLanguage == 'en' ? getSelectedItemWidget(AppLocalizations.of(context)!.english):
              getUnSelectedItemWidget(AppLocalizations.of(context)!.english)
          ),
        ],
      ),
    );
  }

  Widget getSelectedItemWidget(String language){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(language,style: Theme.of(context).textTheme.titleMedium),
          Icon(Icons.check,color: MyCustomTheme.primaryColor)
        ],
      ),
    );
  }

  Widget getUnSelectedItemWidget(String language){
    var provider = Provider.of<provider_config>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(language,style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }

}
