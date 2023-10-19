import 'package:flutter/material.dart';

class customTextFormField extends StatefulWidget{
  String label;
  var textFieldController;
  var textValidation;
  customTextFormField({super.key, required this.label,required this.textFieldController,required this.textValidation});

  @override
  State<customTextFormField> createState() => _customTextFormFieldState();
}

class _customTextFormFieldState extends State<customTextFormField> {

  bool passwordVisible=true;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(obscureText: widget.label=="Password" || widget.label == "Confirm Password" ? passwordVisible :false,
    decoration: InputDecoration(hintText: widget.label,hintStyle: Theme.of(context).textTheme.titleSmall,suffixIcon: widget.label=="Password" || widget.label == "Confirm Password" ?
    IconButton(
    icon: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility_off), onPressed: () {
          setState((){passwordVisible = !passwordVisible;},);},):null),
          controller: widget.textFieldController, validator: widget.textValidation),
    );
  }
}