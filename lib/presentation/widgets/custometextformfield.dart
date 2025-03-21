import 'package:flutter/material.dart';
class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final IconData icon;
  final TextEditingController controller;
  final Color errorTextColor;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final TextInputType keyboardType;
  final Color errorBorderColor;
  final Color focusedErrorBorderColor;
  final TextStyle? errorTextStyle;
  final Color labelTextColor;
  final Color hintTextColor;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.icon,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.errorBorderColor = Colors.red,
    this.focusedErrorBorderColor = Colors.green,
    this.errorTextStyle,
    this.labelTextColor = Colors.grey,
    this.hintTextColor = Colors.grey,
    this.errorTextColor = Colors.red,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: Icon(widget.icon),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        errorStyle: TextStyle(color: widget.errorTextColor),
        hintText: widget.hintText,
        labelStyle: TextStyle(color: widget.labelTextColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.errorBorderColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.focusedErrorBorderColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: widget.validator,
    );
  }
}
