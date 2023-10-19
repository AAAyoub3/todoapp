import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/auth/login_screen.dart';
import '../Home/Home_Screen.dart';
import '../user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'customTextFormField.dart';

class sign_up_screen extends StatefulWidget{
  static const String routeName = 'register_screen';

  @override
  State<sign_up_screen> createState() => _sign_up_screenState();
}

class _sign_up_screenState extends State<sign_up_screen> {
  final formKey = GlobalKey<FormState>();
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register"), centerTitle: true,),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              customTextFormField(label: "User Name",textFieldController: _usernameController,textValidation: TextValidation),
              customTextFormField(label: "Email Address",textFieldController: _emailController,textValidation: TextValidation),
              customTextFormField(label: "Password",textFieldController: _passwordController,textValidation: TextValidation),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: _signUp , child: const Text("Sign up")),
              SizedBox(height: 20,),
              InkWell(child: Text("Already have an account? Login",style: Theme.of(context).textTheme.titleSmall),onTap: () {
                Navigator.of(context).pushReplacementNamed(login_screen.routeName);
              },)
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    if(formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      User? user = await _auth.signUpWithEmailAndPassword(email, password);

      if (user != null) {
        _showMyDialog();
      } else {
        print("Some error has happened");
      }
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text("User is successfully created"),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(login_screen.routeName);
                },
              ),
            ],
          );
        }
    );
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