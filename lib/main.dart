import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Providers/provider_list.dart';
import 'package:untitled1/auth/login_screen.dart';
import 'package:untitled1/auth/sign_up_screen.dart';
import '../Tasks/Edit_tab.dart';
import 'Providers/app_config_provider.dart';
import 'Tasks/Tasks_List_tab.dart';
import 'Theme/MyCustomTheme.dart';
import 'Home/Home_Screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => provider_list(),),
      ChangeNotifierProvider(create: (context) => provider_config())]
    ,child: MyApp(),));

}



class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<provider_config>(context);
    return MaterialApp(
      theme: MyCustomTheme(context).mylightTheme,
      darkTheme:MyCustomTheme(context).mydarkTheme,
      themeMode: provider.appTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: login_screen.routeName ,
      routes:{
        login_screen.routeName : (context) => login_screen(),
        sign_up_screen.routeName : (context) => sign_up_screen(),
        Home_screen.routeName : (context) => Home_screen(),
        Tasks_List_tab.routeName : (context) => Tasks_List_tab(),
        Edit_tab.routeName : (context) => Edit_tab(),
      } ,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(provider.appLanguage)
    );
  }

}