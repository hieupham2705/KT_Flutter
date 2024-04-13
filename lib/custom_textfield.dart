import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController inputEditingControler;
  final IconData suffixIcon;
  final bool isIcon;
  final TextCapitalization textCapitalization;
  final TextInputType inputType;
  final String title;

  const CustomTextField({
    super.key,
    required this.inputEditingControler,
    this.textCapitalization = TextCapitalization.none,
    required this.inputType,
    this.suffixIcon = Icons.add,
    required this.isIcon, required this.title,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
         Text(
          widget.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextField(
          maxLines: 1,
          controller: widget.inputEditingControler,
          textCapitalization: widget.textCapitalization,
          maxLength: 32,
          keyboardType: widget.inputType,
          textAlign: TextAlign.start,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.black54, fontSize: 18),
          decoration: InputDecoration(
              suffixIcon: widget.isIcon
                  ? IconButton(
                      icon: Icon(
                        widget.suffixIcon,
                        color: Colors.black45,
                        size: 30,
                      ),
                      onPressed: () {},
                    )
                  : const SizedBox(
                      width: 0,
                    ),
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
        )
      ],
    );
  }
}
