import 'package:flutter/material.dart';
import 'package:tp_classes_listview/data/bookslist.dart';

class DescriptionScreen extends StatelessWidget {
  static const String name = 'description';
  final BooksInfo? localBookInfo;
  const DescriptionScreen({super.key, this.localBookInfo});

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
              '${localBookInfo?.title} (${localBookInfo?.publishDate})',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text('${localBookInfo?.autor}',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            tryCreateImage('${localBookInfo?.imageURL}'),
            const SizedBox(height: 10),
            Text('${localBookInfo?.description}',
                style: const TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }

  Widget tryCreateImage(String url) {
    return Image.network(
      url,
      height: 400,
      width: double.maxFinite,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.image_not_supported, size: 200);
      },
    );
  }
}
