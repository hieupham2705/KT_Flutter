import 'package:flutter/material.dart';
import 'custom_textfield.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  List<String> listRemind = <String>[
    '10 minute early',
    '30 minute early',
    '1 hour early'
  ];
  List<String> listRepeat = <String>['weekly', 'monthly', 'yearly'];
  late String dropdownRemindValue = listRemind.first;
  late String dropdownRepeatValue = listRepeat.first;
  final TextEditingController title = TextEditingController();
  late TextEditingController deadline = TextEditingController();
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTextField(
                title: "Title",
                isIcon: false,
                inputEditingControler: title,
                inputType: TextInputType.text),
            CustomTextField(
                title: 'Deadline',
                isIcon: true,
                suffixIcon: Icons.calendar_month,
                inputEditingControler: deadline,
                inputType: TextInputType.text),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                      title: 'Start time',
                      isIcon: true,
                      suffixIcon: Icons.timelapse,
                      inputEditingControler: deadline,
                      inputType: TextInputType.text),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomTextField(
                      title: 'End time',
                      isIcon: true,
                      suffixIcon: Icons.timelapse,
                      inputEditingControler: deadline,
                      inputType: TextInputType.text),
                ),
              ],
            ),
            DropdownMenuExample(
              list: listRemind,
              title: 'Remind',
            ),
            DropdownMenuExample(
              list: listRemind,
              title: 'Repeat',
            ),
            ListView.builder(
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext context, int index) {
                  // return Checkbox(
                  //   checkColor: Colors.white,
                  //   value: widget.isChecked,
                  //   onChanged: (bool? value) {
                  //     setState(() {
                  //       widget.isChecked = !widget.isChecked;
                  //     });
                  //   },
                  // ),
                })
          ],
        ),
      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key, required this.list, required this.title});
  final String title;
  final List<String> list;

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  late String dropdownValue = widget.list.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start    ,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: DropdownButton<String>(
            padding: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(5 ),
            elevation: 0,
            value: dropdownValue,
            underline: Container(),
            icon: const Icon(Icons.arrow_drop_down_sharp),
            style: const TextStyle(
                color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
            onChanged: (String? value) {
              setState(() {
                dropdownValue = value!;
              });
            },
            items: widget.list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            isExpanded: true,
          ),
        )
      ],
    );
  }
}
