import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController inputEditingControler;
  final String name;
  final IconData prefixIcon;
  final bool obscureIconEyeText;
  final TextCapitalization textCapitalization;
  final TextInputType inputType;

  const CustomTextField(
      {super.key,
      required this.inputEditingControler,
      required this.name, this.prefixIcon = Icons.add,
      this.textCapitalization = TextCapitalization.none,
      required this.inputType,
      this.obscureIconEyeText = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      controller: widget.inputEditingControler,
      textCapitalization: widget.textCapitalization,
      maxLength: 32,
      keyboardType: widget.inputType,
      textAlign: TextAlign.start,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black54, fontSize: 16),
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(5), // add padding to adjust icon
            child: Icon(widget.prefixIcon),
          ),
          labelText: widget.name,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          isDense: true,
          counterText: '',
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          contentPadding: const EdgeInsets.all(10)),
    );
  }
}
