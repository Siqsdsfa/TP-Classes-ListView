import 'package:flutter/material.dart';
import 'package:tp_classes_listview/screens/home_screen.dart';

class DescriptionScreen extends StatelessWidget {
  static const String name = 'description';
  final BooksInfo? localBooksInfo;
  const DescriptionScreen(
      {super.key,
      this.localBooksInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text('Book Description'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Text(
              '${localBooksInfo?.title} (${localBooksInfo?.publishDate})',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text('${localBooksInfo?.autor}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Image.network(
              '${localBooksInfo?.imageURL}',
              height: 400,
              width: double.maxFinite,
            ),
            const SizedBox(height: 10),
            Text('${localBooksInfo?.description}', style: const TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
