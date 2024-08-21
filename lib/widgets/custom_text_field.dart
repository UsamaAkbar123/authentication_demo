import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;

  final TextInputType keyboardType;
  final IconData? prefixIcon;

  final bool showObscureIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.showObscureIcon = false,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = false;

  void _toggleObscure() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscured,
      keyboardType: widget.keyboardType,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: Colors.white,
                size: 18.h,
              )
            : null,
        suffixIcon: widget.showObscureIcon
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                  size: 20.h,
                ),
                onPressed: _toggleObscure,
              )
            : null,
        hintText: widget.labelText,
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
