import 'dart:math';

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController inputEditingControler;
  final IconData suffixIcon;
  final bool isIcon;
  final TextCapitalization textCapitalization;
  final TextInputType inputType;
  final String title;
  final String type;
  const CustomTextField({
    super.key,
    required this.inputEditingControler,
    this.textCapitalization = TextCapitalization.none,
    required this.inputType,
    this.suffixIcon = Icons.add,
    required this.isIcon, required this.title, this.type ='',
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = false;
  String text = '';
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
                      onPressed: () =>{
                        if(widget.type == 'date'){
                          _selectDate(context)
                        }
                        else{
                          _selectTime(context)
                        }
                      },
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
  // date piker
  DateTime? _selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.inputEditingControler.text = _selectedDate != null
            ? _selectedDate!.toString().substring(0, 10)
            : 'No date selected';
      });
    }
  }
  // timepicker
  TimeOfDay? _selectedTime;
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        widget.inputEditingControler.text = _selectedTime != null
            ? _selectedTime!.format(context)
            : 'No time selected';
      });
    }
  }
}
