import 'package:flutter/material.dart';

Widget defaultFormaFielde({
  required TextEditingController controllerField,
  TextInputType? keyboardType,
  bool isPassword = false,
  required String text,
  required IconData prefixIcon,
  IconData? suffixIcon,
  required String? Function(String?) validatorField,
  Function()? showPassword,
  Function(String)? onSubmitted,
  Function(String)? onChanged,
  Function()? onTap,
  String? border,
  bool? dense = false,
}) =>
    TextFormField(
      controller: controllerField,
      keyboardType: keyboardType,
      onTap: onTap,
      obscureText: isPassword,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: dense,
        contentPadding: dense == true ? const EdgeInsets.all(0) : null,
        hintText: text,
        border: border == 'rounded'
            ? OutlineInputBorder(borderRadius: BorderRadius.circular(50))
            : border == 'outlined'
                ? const OutlineInputBorder()
                : null,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon:
            GestureDetector(onTap: showPassword, child: Icon(suffixIcon)),
      ),
      validator: validatorField,
    );

Widget defaultButton({
  Color? colorButton,
  required String textButton,
  required Function() functionButton,
}) =>
    Container(
      width: double.infinity,
      color: colorButton,
      child: MaterialButton(
        onPressed: functionButton,
        child: Text(
          textButton,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

void NavigateTo(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

void NavigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => Widget),
    (Route<dynamic> route) => false);
