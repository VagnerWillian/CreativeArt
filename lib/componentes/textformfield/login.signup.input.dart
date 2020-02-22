import 'package:flutter/material.dart';

Widget TextInputCustom(String hint, {bool obscure, TextEditingController controller}){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.black38,
    ),
    child: TextFormField(
      controller: controller,
      obscureText: obscure ?? false,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
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