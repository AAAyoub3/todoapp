import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/Home/Home_Screen.dart';
import 'package:untitled1/auth/sign_up_screen.dart';

import '../user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'customTextFormField.dart';

class login_screen extends StatefulWidget{
  static const String routeName = 'login_screen';
  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  final formKey = GlobalKey<FormState>();
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login"), centerTitle: true,),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              customTextFormField(label: "Email",textFieldController: _emailController,textValidation: TextValidation),
              customTextFormField(label: "Password",textFieldController: _passwordController,textValidation: TextValidation),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: _signIn, child: const Text("Log in")),
              SizedBox(height: 20,),
              InkWell(child: Text("Create new account",style: Theme.of(context).textTheme.titleSmall),onTap: () {
                Navigator.of(context).pushReplacementNamed(sign_up_screen.routeName);
              },)
            ],
          ),
        ),
      ),
    );
  }
  void _signIn() async {
    if(formKey.currentState!.validate()){
        String email = _emailController.text;
        String password = _passwordController.text;
        User? user = await _auth.signInWithEmailAndPassword(email, password);
        if (user!= null){Navigator.of(context).pop();}
        else{print("Some error has happened");}
    }
  }
  String? TextValidation(String? text){
    if (text!.isEmpty){
      print("Empty Field");
      return "Empty Field";
    }
    else {
      return null; // There is a text in task or description
    }
  }
}