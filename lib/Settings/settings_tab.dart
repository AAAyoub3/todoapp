import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Settings/theme_sheet_list.dart';
import '../Providers/app_config_provider.dart';
import '../Theme/MyCustomTheme.dart';
import 'Language_sheet_list.dart';

class settings_tab extends StatefulWidget{
  @override
  State<settings_tab> createState() => _settings_tabState();
}

class _settings_tabState extends State<settings_tab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<provider_config>(context);
    return Column(
      children: [
        SizedBox(height: 10,),
        Text(AppLocalizations.of(context)!.language,style: Theme.of(context).textTheme.titleMedium,),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: MyCustomTheme.primaryColor,
                borderRadius: BorderRadius.circular(10)
            ),

            child: InkWell(
              onTap: (){
                showLanguageSheet();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.arrow_drop_down),
                    Text(provider.appLanguage == "en" ?AppLocalizations.of(context)!.english :AppLocalizations.of(context)!.arabic,
                      style: Theme.of(context).textTheme.titleMedium,)
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
        Text(AppLocalizations.of(context)!.theme,style: Theme.of(context).textTheme.titleMedium,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: MyCustomTheme.primaryColor,
                borderRadius: BorderRadius.circular(10)
            ),

            child: InkWell(
              onTap: (){
                showThemeSheet();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.arrow_drop_down),
                    Text(provider.appTheme == ThemeMode.light ?AppLocalizations.of(context)!.lightTheme:AppLocalizations.of(context)!.darkTheme,
                    style: Theme.of(context).textTheme.titleMedium,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showLanguageSheet() {
    showModalBottomSheet(
        context: context,
        builder:(context)=> Language_sheet_list(),
    );

  }

  void showThemeSheet() {
    showModalBottomSheet(
        context: context,
        builder:(context)=> theme_sheet_list(),
    );
  }
}