import 'package:flutter/material.dart';
import 'addTask.dart';
import 'package:ktra/data.dart';

List<DataAddtask> listTask = [
  // DataAddtask('Lam viec', '07:34', '07:34', '2023-01-01', true, true,
  //     '10 minutes early', 'weakly'),
  // DataAddtask('Lam viec', '07:34', '07:34', '2023-01-01', true, true,
  //     '10 minutes early', 'weakly'),
  // DataAddtask('Lam viec', '07:34', '07:34', '2023-01-01', true, true,
  //     '10 minutes early', 'weakly'),
  // DataAddtask('Lam viec', '07:34', '07:34', '2023-01-01', true, true,
  //     '10 minutes early', 'weakly'),
  // DataAddtask('Lam viec', '07:34', '07:34', '2023-01-01', true, true,
  //     '10 minutes early', 'weakly'),
  // DataAddtask('Lam viec', '07:34', '07:34', '2023-01-01', true, true,
  //     '10 minutes early', 'weakly'),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    // listTask.add(data(true,'','','','',true,''));
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              const Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Board",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.notifications)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.calendar_month)),
            ],
          ),
          TabBar(
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                text: "All",
              ),
              Tab(
                text: "Uncompleted",
              ),
              Tab(
                text: "Completed",
              ),
              Tab(
                text: "Favourite",
              ),
            ],
          ),
          Expanded(
            child: Fragment(
              tabController: _tabController,
              listTask: listTask,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 150, vertical: 7),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                _navigateAndDisplaySelection(context);
              },
              child: const Text('Add a task',
                  style: TextStyle(color: Colors.white))),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    ));
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final task = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTask()),
    );
    if (!context.mounted) return task;
    setState(() {
      listTask.add(task);
    });
  }
}

class Fragment extends StatefulWidget {
  const Fragment(
      {super.key, required this.tabController, required this.listTask});

  final List<DataAddtask> listTask;
  final TabController tabController;

  @override
  State<Fragment> createState() => _FragmentState();
}

class _FragmentState extends State<Fragment> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.tabController,
      children: <Widget>[
        Center(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: widget.listTask.length,
                itemBuilder: (BuildContext context, int index) {
                  return  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: listTask[index].color,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: listTask[index].isCompleted,
                          onChanged: (bool? value) {
                            setState(() {
                              listTask[index].isCompleted =
                              !listTask[index].isCompleted;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listTask[index].title,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                  'From: ${listTask[index].startTime} - To: ${listTask[index].endTime}',
                                  style: const TextStyle(fontSize: 14, color: Colors.white)),
                              Text('Deadline ${listTask[index].deadline}',
                                  style: const TextStyle(fontSize: 14, color: Colors.white)),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              listTask[index].isFavorite =
                              !listTask[index].isFavorite;
                            });
                          },
                          icon: const Icon(Icons.heart_broken_outlined),
                          color: listTask[index].isFavorite ? Colors.red : Colors.grey,
                        )
                      ],
                    ),
                  );
                })),
        Center(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: widget.listTask.length,
            itemBuilder: (BuildContext context, int index) {
              if (!widget.listTask[index].isCompleted) {
                return  Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: listTask[index].color,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: listTask[index].isCompleted,
                        onChanged: (bool? value) {
                          setState(() {
                            listTask[index].isCompleted =
                            !listTask[index].isCompleted;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listTask[index].title,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                                'From: ${listTask[index].startTime} - To: ${listTask[index].endTime}',
                                style: const TextStyle(fontSize: 14, color: Colors.white)),
                            Text('Deadline ${listTask[index].deadline}',
                                style: const TextStyle(fontSize: 14, color: Colors.white)),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            listTask[index].isFavorite =
                            !listTask[index].isFavorite;
                          });
                        },
                        icon: const Icon(Icons.heart_broken_outlined),
                        color: listTask[index].isFavorite ? Colors.red : Colors.grey,
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
        Center(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: widget.listTask.length,
            itemBuilder: (BuildContext context, int index) {
              if (widget.listTask[index].isCompleted) {
                return  Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: listTask[index].color,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: listTask[index].isCompleted,
                        onChanged: (bool? value) {
                          setState(() {
                            listTask[index].isCompleted =
                            !listTask[index].isCompleted;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listTask[index].title,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                                'From: ${listTask[index].startTime} - To: ${listTask[index].endTime}',
                                style: const TextStyle(fontSize: 14, color: Colors.white)),
                            Text('Deadline ${listTask[index].deadline}',
                                style: const TextStyle(fontSize: 14, color: Colors.white)),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            listTask[index].isFavorite =
                            !listTask[index].isFavorite;
                          });
                        },
                        icon: const Icon(Icons.heart_broken_outlined),
                        color: listTask[index].isFavorite ? Colors.red : Colors.grey,
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
        Center(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: widget.listTask.length,
                itemBuilder: (BuildContext context, int index) {
                  if (widget.listTask[index].isFavorite) {
                    return  Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: listTask[index].color,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            value: listTask[index].isCompleted,
                            onChanged: (bool? value) {
                              setState(() {
                                listTask[index].isCompleted =
                                !listTask[index].isCompleted;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  listTask[index].title,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                    'From: ${listTask[index].startTime} - To: ${listTask[index].endTime}',
                                    style: const TextStyle(fontSize: 14, color: Colors.white)),
                                Text('Deadline ${listTask[index].deadline}',
                                    style: const TextStyle(fontSize: 14, color: Colors.white)),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                listTask[index].isFavorite =
                                !listTask[index].isFavorite;
                              });
                            },
                            icon: const Icon(Icons.heart_broken_outlined),
                            color: listTask[index].isFavorite ? Colors.red : Colors.grey,
                          )
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                })),
      ],
    );
  }
}

// class Item extends StatefulWidget {
//   const Item({super.key, required this.index});
//
//   final int index;
//
//   @override
//   State<Item> createState() => _ItemState();
// }
//
// class _ItemState extends State<Item> {
//   @override
//   Widget build(BuildContext context) {
//     return;
//   }
// }
