import 'package:flutter/material.dart';

class TextInputCustom extends StatefulWidget {

  String hint;
  bool obscure;
  TextEditingController controller;
  Function validator;
  Function onChanged;
  TextInputType textInputType;

  TextInputCustom({this.hint,this.obscure, this.controller, this.validator, this.onChanged, this.textInputType});

  @override
  _TextInputCustomState createState() => _TextInputCustomState(this.hint, this.obscure, this.controller, this.validator, this.onChanged, this.textInputType);
}

class _TextInputCustomState extends State<TextInputCustom> {

  String hint;
  bool obscure;
  bool isObscure = false;
  TextEditingController controller;
  Function validator;
  Function onChanged;
  TextInputType textInputType;

  _TextInputCustomState(this.hint, this.obscure, this.controller, this.validator, this.onChanged, this.textInputType);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black38,
      ),
      child: TextFormField(
        onChanged: onChanged,
        keyboardType: textInputType,
        validator: (str)=>validator(str),
        controller: controller,
        obscureText: obscure == true ? isObscure ? false : true : false,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          suffixIcon: obscure != true ? null :
          RaisedButton(elevation: 0, onPressed: _showObscure, child: Icon(isObscure ? Icons.visibility_off : Icons.visibility, color: Colors.grey,),color: Colors.transparent,),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          fillColor: Colors.red,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white12),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  _showObscure(){
    setState(() {
      isObscure = !isObscure;
    });
  }
}