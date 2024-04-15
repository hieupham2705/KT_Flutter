import 'package:flutter/material.dart';
import 'package:ktra/data.dart';
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
  List<colors> listCheckColor = <colors>[
    colors(Colors.red, true),
    colors(Colors.yellow, false),
    colors(Colors.green, false),
    colors(Colors.blue, false),
    colors(Colors.purple, false),
  ];
  late String dropdownRemindValue = listRemind.first;
  late String dropdownRepeatValue = listRepeat.first;
  final TextEditingController title = TextEditingController();
  late TextEditingController deadline = TextEditingController();
  late TextEditingController startTime = TextEditingController();
  late TextEditingController endTime = TextEditingController();
  late TextEditingController remind = TextEditingController();
  late TextEditingController repeat = TextEditingController();
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
        child: SingleChildScrollView(
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
                  type: 'date',
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
                        inputEditingControler: startTime,
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
                        inputEditingControler: endTime,
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
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10)),
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listCheckColor.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Transform.scale(
                          alignment: Alignment.center,
                          scale: 2.5,
                          child: Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return listCheckColor[index]
                                    .color
                                    .withOpacity(.32);
                              }
                              return listCheckColor[index].color;
                            }),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            side: BorderSide(
                                color: listCheckColor[index].isCheckColor
                                    ? Colors.grey
                                    : Colors.transparent,
                                width: 3),
                            value: listCheckColor[index].isCheckColor,
                            onChanged: (bool? value) {
                              setState(
                                () {
                                  for (int i = 0;
                                      i < listCheckColor.length;
                                      i++) {
                                    if (i == index) {
                                      listCheckColor[index].isCheckColor =
                                          !listCheckColor[index].isCheckColor;
                                    } else {
                                      listCheckColor[i].isCheckColor = false;
                                    }
                                  }
                                },
                              );
                            },
                          )),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        if (checkAll()) {
                          Navigator.pop(
                              context,
                              DataAddtask(
                                  title.text,
                                  startTime.text,
                                  endTime.text,
                                  deadline.text,
                                  false,
                                  false,
                                  remind.text,
                                  repeat.text,
                                  getColor()));
                        }
                      },
                      child: const Text(
                        'Add task',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Color getColor() {
    for (int i = 0; i < listCheckColor.length; i++) {
      if (listCheckColor[i].isCheckColor) return listCheckColor[i].color;
    }
    return Colors.red;
  }

  bool checkAll() {
    if (title.text.isEmpty) {
      showToast('title');
      return false;
    }
    if (deadline.text.isEmpty) {
      showToast('deadline');
      return false;
    }
    if (startTime.text.isEmpty) {
      showToast('startTime');
      return false;
    }
    if (endTime.text.isEmpty) {
      showToast('endTime');
      return false;
    }
    if (title.text.isEmpty) {
      showToast('title');
      return false;
    }
    return true;
  }

  void showToast(String result) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('Vui lòng nhập $result')));
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample(
      {super.key, required this.list, required this.title});

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
      crossAxisAlignment: CrossAxisAlignment.start,
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
            borderRadius: BorderRadius.circular(5),
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

class colors {
  late Color color;
  late bool isCheckColor;

  colors(this.color, this.isCheckColor);
}
