import 'package:flutter/material.dart';
import 'custom_textfield.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController title = TextEditingController();
  late TextEditingController dealine;
  late TextEditingController startTime;
  late TextEditingController endTime;
  late TextEditingController remind;
  late TextEditingController repeat;
  late TextEditingController color;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add task'),
      ),
      body: Column(
        children: [
          const Text('Title'),
          CustomTextField(
              inputEditingControler: title,
              name: 'title',
              inputType: TextInputType.text)
        ],
      ),
    );
  }
}
