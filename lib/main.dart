import 'package:flutter/material.dart';
import 'addTask.dart';

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
  List<data> listTask = [
    data(true, 'Lam Viec', '07:34 PM', '07:34 PM', '2020-1-1', true,
        'Completed'),
    data(true, 'Lam Viec', '07:34 PM', '07:34 PM', '2020-1-1', true,
        'Completed'),
    data(true, 'Lam Viec', '07:34 PM', '07:34 PM', '2020-1-1', true,
        'Completed'),
    data(true, 'Lam Viec', '07:34 PM', '07:34 PM', '2020-1-1', true,
        'Completed'),
  ];

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
          Fragment(
            tabController: _tabController,
            listTask: listTask,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 7),
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => AddTask()));
              },
              child:  const Text('Add a task',style: TextStyle(color: Colors.white)))
        ],
      ),
    ));
  }
}

class Fragment extends StatelessWidget {
  const Fragment(
      {super.key, required this.tabController, required this.listTask});

  final List<data> listTask;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: TabBarView(
        controller: tabController,
        children: <Widget>[
          Center(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: listTask.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Item(
                        isChecked: listTask[index].isChecked,
                        title: listTask[index].title,
                        to: listTask[index].to,
                        from: listTask[index].from,
                        dealine: listTask[index].dealine,
                        heartChecked: listTask[index].heartChecked);
                  })),
          Center(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: getList(listTask, 'Uncomplated').length,
                  itemBuilder: (BuildContext context, int index) {
                    return Item(
                        isChecked: listTask[index].isChecked,
                        title: listTask[index].title,
                        to: listTask[index].to,
                        from: listTask[index].from,
                        dealine: listTask[index].dealine,
                        heartChecked: listTask[index].heartChecked);
                  })),
          Center(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: getList(listTask, 'Completed').length,
                  itemBuilder: (BuildContext context, int index) {
                    return Item(
                        isChecked: listTask[index].isChecked,
                        title: listTask[index].title,
                        to: listTask[index].to,
                        from: listTask[index].from,
                        dealine: listTask[index].dealine,
                        heartChecked: listTask[index].heartChecked);
                  })),
          Center(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: getList(listTask, 'Favourite').length,
                  itemBuilder: (BuildContext context, int index) {
                    return Item(
                        isChecked: listTask[index].isChecked,
                        title: listTask[index].title,
                        to: listTask[index].to,
                        from: listTask[index].from,
                        dealine: listTask[index].dealine,
                        heartChecked: listTask[index].heartChecked);
                  })),
        ],
      ),
    );
  }

  List getList(List<data> list, String type) {
    return list.where((element) => element.type == type).toList();
  }
}

class Item extends StatefulWidget {
  Item(
      {super.key,
      required this.isChecked,
      required this.title,
      required this.to,
      required this.from,
      required this.dealine,
      required this.heartChecked});

  late bool isChecked;
  final String title;
  final String to;
  final String from;
  final String dealine;
  bool heartChecked;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            checkColor: Colors.white,
            value: widget.isChecked,
            onChanged: (bool? value) {
              setState(() {
                widget.isChecked = !widget.isChecked;
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
                  widget.title,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text('From: ${widget.from} - To: ${widget.to}',
                    style: const TextStyle(fontSize: 14, color: Colors.white)),
                Text('Dealine ${widget.dealine}',
                    style: const TextStyle(fontSize: 14, color: Colors.white)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                widget.heartChecked = !widget.heartChecked;
              });
            },
            icon: const Icon(Icons.heart_broken_outlined),
            color: widget.heartChecked ? Colors.red : Colors.grey,
          )
        ],
      ),
    );
  }
}

class data {
  late bool isChecked;
  late String title;
  late String to;
  late String from;
  late String dealine;
  late bool heartChecked;
  late String type;

  data(this.isChecked, this.title, this.to, this.from, this.dealine,
      this.heartChecked, this.type);
}
