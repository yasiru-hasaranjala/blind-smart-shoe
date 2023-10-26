import 'package:flutter/material.dart';

Widget commonButton({
  required Function? function,
  required String text,
  double radius = 5,
  double height = 50,
  double width = double.infinity,
  double fontsize = 25.0,
  double border = 0.0,
  fontWeight,
  Color color = Colors.white,
  Color textcolor = Colors.indigo,
}) =>
    Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: textcolor,
            width: border,
          )),
      height: height,
      width: width,
      child: MaterialButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        color: color,
        splashColor: color,
        onPressed: function ?? nullable(),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: fontWeight,
            fontSize: fontsize,
            color: textcolor,
          ),
        ),
      ),
    );

Widget iconSocialmedia({
  String url = 'https://cdn0.iconfinder.com/data/icons/shift-free/32/Error-512.png',
  double size = 40,
}) =>
    MaterialButton(
      elevation: 0,
      highlightColor: Colors.indigo,
      hoverColor: Colors.indigo,
      shape: const CircleBorder(),
      color: Colors.indigo,
      onPressed: () {},
      child: Image(
        image: NetworkImage(url),
        color: Colors.white60,
        height: size,
        width: size,
      ),
    );

Widget textField({
  required String hinttext,
  required suffixIcon,
  final controller,
  bool isPassword = false,
  bool isPasswordVisible = false,
  keyboardType,
  onChange,
  Color color1 = Colors.black,
}) =>
    SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChange,
        cursorColor: Colors.white60,
        style: TextStyle(color: Colors.white),
        validator: (value) {
          if (isPassword & (value!.length < 8)) {
            return 'must be at lest 8 character';
          } else if (value.isEmpty) {
            return 'Cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.white60),
          suffixIcon: suffixIcon,
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.red),
          ),
          errorStyle: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
          enabledBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(width: 3, color: color1),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3.0),
          ),
        ),
        textInputAction: TextInputAction.done,
        obscureText: isPasswordVisible,
      ),
    );

nullable() {}
