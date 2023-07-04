import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defualtButton({
  double width = double.infinity,
  Color background = const Color(0xff2E91A3),
  bool isUpperCase = true,
  double radius = 10.0,
  required VoidCallback function,
   required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defualtTextButton({
  required VoidCallback function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );

Widget defualtFormField(
        {
          required TextEditingController controller,
        required TextInputType type,
        void Function(String?)? onSubmit,
        void Function(String?)? onChange,
        bool isPassword = false,
        bool readOnly = false,
        required FormFieldValidator<String>? validate,
        required String label,
        required IconData prefix,
        IconData? suffix,
        void Function()? suffixPressed,
        void Function()? onTap}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      readOnly: readOnly,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      onChanged: onChange,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );


Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void NavigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void NavigateAndReplace(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );

void ShowToast({required String text, required ToastStates state }) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 8,
    backgroundColor:toastColor(state),
    textColor: Colors.white,
    fontSize: 16.0);

enum ToastStates{success, error, warning}

Color toastColor (ToastStates state){
  Color color;
  switch(state)
  {
    case ToastStates.success:
      color =Colors.green;
    break;
    case ToastStates.error:
      color =Colors.red;
    break;
    case ToastStates.warning:
      color =Colors.amber;
    break;

  }
  return color;
}