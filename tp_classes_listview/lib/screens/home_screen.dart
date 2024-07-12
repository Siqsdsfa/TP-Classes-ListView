import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_classes_listview/data/bookslist.dart';
import 'package:tp_classes_listview/screens/item_description_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String name = 'home';
  final String userName;
  const HomeScreen({super.key, this.userName = ''});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController autorController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController publishDateController = TextEditingController();
  TextEditingController imageURLController = TextEditingController();

  bool _validURL = false;
  bool isCheckingImage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text("Books"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              clearTextControllers();
              createNewBook();
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
                ListView.builder(
                  itemCount: booksList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final tile = booksList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Card(
                        elevation: 4,
                        shadowColor: Colors.black12,
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () {
                              _goToBookDetails(context, tile);
                            },
                            icon: const Icon(Icons.open_in_new),
                          ),
                          title: Column(
                            children: [
                              Text(
                                tile.title,
                                style: const TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              tryCreateImage(tile.imageURL),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              booksList.removeAt(index);
                              setState(() {});
                            },
                            icon: const Icon(Icons.remove_rounded),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _goToBookDetails(BuildContext context, BooksInfo tile) {
    context.pushNamed(
      DescriptionScreen.name,
      extra: BooksInfo(
        title: tile.title,
        autor: tile.autor,
        description: tile.description,
        publishDate: tile.publishDate,
        imageURL: tile.imageURL,
      ),
    );
  }

  Future createNewBook() => showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                insetPadding: const EdgeInsets.only(top: 60, bottom: 60),
                scrollable: true,
                title: const Text("Book"),
                content: Column(
                  children: [
                    createNewBookTextField('Title',
                        const Icon(Icons.text_fields_rounded), titleController),
                    const SizedBox(height: 5),
                    createNewBookTextField(
                        'Autor', const Icon(Icons.person), autorController),
                    const SizedBox(height: 5),
                    createNewBookTextField(
                        'Description',
                        const Icon(Icons.text_fields_rounded),
                        descriptionController),
                    const SizedBox(height: 5),
                    createNewBookTextField(
                        'Date of publication',
                        const Icon(Icons.date_range_outlined),
                        publishDateController),
                    const SizedBox(height: 5),
                    createNewBookTextField('Image url', const Icon(Icons.link),
                        imageURLController),
                    const SizedBox(height: 5),
                    TextButton(
                      onPressed: () {
                        setState(() => isCheckingImage = true);
                      },
                      child: const Text("Check Image"),
                    ),
                    isCheckingImage
                        ? tryCreateImage(imageURLController.text)
                        : const SizedBox(),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      handleCreateNewBook(context);
                    },
                    child: const Text("Submit"),
                  ),
                ],
              );
            },
          );
        },
      );

  Widget tryCreateImage(String url) {
    return Image.network(
      url,
      height: 200,
      width: double.maxFinite,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.image_not_supported, size: 120);
      },
    );
  }

  void handleCreateNewBook(BuildContext context) {
    if (titleController.text.isEmpty ||
        autorController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        publishDateController.text.isEmpty ||
        imageURLController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Empty Fields')),
      );
    } else {
      _validURL =
          Uri.tryParse(imageURLController.text)?.hasAbsolutePath ?? false;
      if (_validURL == true) {
        setState(() {
          booksList.add(
            BooksInfo(
              title: titleController.text,
              autor: autorController.text,
              description: descriptionController.text,
              publishDate: publishDateController.text,
              imageURL: imageURLController.text,
            ),
          );
        });
        clearTextControllers();
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid URL')),
        );
      }
    }
  }

  void clearTextControllers() {
    titleController.clear();
    autorController.clear();
    descriptionController.clear();
    publishDateController.clear();
    imageURLController.clear();
    isCheckingImage = false;
  }
}

Widget createNewBookTextField(
    String title, Icon icon, TextEditingController controller) {
  return TextField(
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      labelText: title,
      prefixIcon: icon,
      hintText: title,
    ),
    controller: controller,
  );
}
