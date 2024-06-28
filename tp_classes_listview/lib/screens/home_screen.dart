import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String name = 'home';
  final String userName;
  const HomeScreen({super.key, this.userName = ''});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController toDoListController = TextEditingController();
  TextEditingController dueToTextController = TextEditingController();
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text("To Do List"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              toDoListController.clear();
              dueToTextController.clear();
              errorText = '';
              createNewTask();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome ${widget.userName}!'),
                const SizedBox(height: 40),
                SizedBox(
                  height: toDoListCards.length * 80,
                  child: ListView.builder(
                    itemCount: toDoListCards.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final tile = toDoListCards[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Card(
                          elevation: 4,
                          shadowColor: Colors.black12,
                          child: ListTile(
                            leading: IconButton(
                              onPressed: () {
                                toDoListController.text = tile.descriptionCard;
                                dueToTextController.text = tile.dueTo;
                                errorText = '';
                                modifyTask(index);
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            title: Column(
                              children: [
                                Text(
                                  tile.descriptionCard,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(
                                  tile.dueTo,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                toDoListCards.removeAt(index);
                                setState(() {});
                              },
                              icon: const Icon(Icons.remove_rounded),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future createNewTask() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          insetPadding: const EdgeInsets.only(top: 60, bottom: 60),
          title: const Text("Task"),
          content: Column(
            children: [
              TextField(
                //style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Task',
                  prefixIcon: const Icon(
                    Icons.text_fields,
                  ),
                  hintText: "Write a new task",
                ),
                maxLines: 3,
                minLines: 1,
                maxLength: 50,
                controller: toDoListController,
              ),
              TextField(
                //style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Due To',
                  prefixIcon: const Icon(
                    Icons.date_range_rounded,
                  ),
                  hintText: "Write a date",
                ),
                maxLines: 1,
                minLines: 1,
                maxLength: 10,
                controller: dueToTextController,
              ),
              Text(
                errorText,
                style: const TextStyle(color: Colors.red),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                String localTaskDescription = toDoListController.text;
                String localDueTo = dueToTextController.text;
                if (localTaskDescription.isEmpty || localDueTo.isEmpty) {
                  setState(() {
                    errorText = 'Empty fields';
                  });
                } else {
                  setState(() {
                    toDoListCards.add(
                      ToDoListCards(
                        dueTo: localDueTo,
                        descriptionCard: localTaskDescription,
                      ),
                    );
                    errorText = '';
                  });
                  toDoListController.clear();
                  dueToTextController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      );

  Future modifyTask(int indexInList) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          scrollable: true,
          insetPadding: const EdgeInsets.only(top: 60, bottom: 60),
          title: const Text("Task"),
          content: Column(
            children: [
              TextField(
                //style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Task',
                  prefixIcon: const Icon(
                    Icons.text_fields,
                  ),
                  hintText: "Modify task",
                ),
                maxLines: 3,
                minLines: 1,
                maxLength: 50,
                controller: toDoListController,
              ),
              TextField(
                //style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Due To',
                  prefixIcon: const Icon(
                    Icons.date_range_rounded,
                  ),
                  hintText: "Modify date",
                ),
                maxLines: 1,
                minLines: 1,
                maxLength: 10,
                controller: dueToTextController,
              ),
              Text(
                errorText,
                style: const TextStyle(color: Colors.red),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                String localTaskDescription = toDoListController.text;
                String localDueTo = dueToTextController.text;
                if (localTaskDescription.isEmpty || localDueTo.isEmpty) {
                  setState(() {
                    errorText = 'Empty fields';
                  });
                } else {
                  setState(() {
                    toDoListCards[indexInList] = ToDoListCards(
                      dueTo: localDueTo,
                      descriptionCard: localTaskDescription,
                    );
                    errorText = '';
                  });
                  toDoListController.clear();
                  dueToTextController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      );
}

class ToDoListCards {
  final String dueTo;
  final String descriptionCard;
  ToDoListCards({
    required this.dueTo,
    required this.descriptionCard,
  });
}

List<ToDoListCards> toDoListCards = [
  ToDoListCards(
    descriptionCard: 'sample',
    dueTo: '18/12/2022',
  ),
];
