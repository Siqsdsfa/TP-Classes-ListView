import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                              ),
                              Image.network(
                                tile.imageURL,
                                height: 200,
                                width: double.maxFinite,
                              ),
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
        builder: (context) => AlertDialog(
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
              createNewBookTextField('Description',
                  const Icon(Icons.text_fields_rounded), descriptionController),
              const SizedBox(height: 5),
              createNewBookTextField('Date of publication',
                  const Icon(Icons.date_range_outlined), publishDateController),
              const SizedBox(height: 5),
              createNewBookTextField(
                  'Image url', const Icon(Icons.link), imageURLController),
              const SizedBox(height: 5),
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
        ),
      );

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

class BooksInfo {
  final String title;
  final String autor;
  final String description;
  final String publishDate;
  final String imageURL;
  BooksInfo({
    required this.title,
    required this.autor,
    required this.description,
    required this.publishDate,
    required this.imageURL,
  });
}

List<BooksInfo> booksList = [
  BooksInfo(
    title: 'The 48 Laws of Power',
    autor: 'Robert Greene',
    description:
        'The 48 Laws of Power (1998) is a self-help book by American author Robert Greene. The book is a New York Times bestseller, selling over 1.2 million copies in the United States.',
    publishDate: '1998',
    imageURL:
        'https://upload.wikimedia.org/wikipedia/en/9/9d/GreeneRobert-48LawsOfPower.jpg',
  ),
  BooksInfo(
    title: 'The 33 Strategies of War',
    autor: 'Robert Greene',
    description:
        'The 33 Strategies of War is a military history and personal development book. It was written by American author Robert Greene in 2006. It is composed of discussions and examples of offensive and defensive strategies from a wide variety of people and conditions, applying them to social conflicts such as family quarrels and business negotiations',
    publishDate: '2006',
    imageURL:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/33StratagiesWar.jpg/200px-33StratagiesWar.jpg',
  ),
  BooksInfo(
    title: 'Meditations',
    autor: 'Marcus Aurelius',
    description:
        "Meditations (Koinē Greek: Τὰ εἰς ἑαυτόν, romanized: Ta eis heauton, lit. 'things to one's self') is a series of personal writings by Marcus Aurelius, Roman Emperor from AD 161 to 180, recording his private notes to himself and ideas on Stoic philosophy.",
    publishDate: 'AD 170',
    imageURL:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/MeditationsMarcusAurelius1811.jpg/220px-MeditationsMarcusAurelius1811.jpg',
  ),
  BooksInfo(
    title: 'Thus Spoke Zarathustra: A Book for All and None',
    autor: 'Friedrich Nietzsche',
    description:
        'Thus Spoke Zarathustra: A Book for All and None (German: Also sprach Zarathustra: Ein Buch für Alle und Keinen), also translated as Thus Spake Zarathustra, is a work of philosophical fiction written by German philosopher Friedrich Nietzsche; it was published in four volumes between 1883 and 1885. The protagonist is nominally the historical Zoroaster.',
    publishDate: '1883',
    imageURL:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/Also_sprach_Zarathustra._Ein_Buch_f%C3%BCr_Alle_und_Keinen._In_drei_Theilen.jpg/220px-Also_sprach_Zarathustra._Ein_Buch_f%C3%BCr_Alle_und_Keinen._In_drei_Theilen.jpg',
  ),
  BooksInfo(
    title: 'The Gay Science',
    autor: 'Friedrich Nietzsche',
    description:
        'The Gay Science (German: Die fröhliche Wissenschaft; sometimes translated as The Joyful Wisdom or The Joyous Science) is a book by Friedrich Nietzsche published in 1882, and followed by a second edition in 1887 after the completion of Thus Spoke Zarathustra and Beyond Good and Evil. This substantial expansion includes the addition of a fifth book to the existing four books of The Gay Science, as well as an appendix of songs. It was described by Nietzsche as "the most personal of all my books", and contains more poems than any of his other works.',
    publishDate: '1882',
    imageURL:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/FW82.jpg/220px-FW82.jpg',
  ),
  BooksInfo(
    title: "Harry Potter and the Philosopher's Stone",
    autor: 'J. K. Rowling',
    description:
        "Harry Potter and the Philosopher's Stone is a fantasy novel written by British author J. K. Rowling. The first novel in the Harry Potter series and Rowling's debut novel, it follows Harry Potter, a young wizard who discovers his magical heritage on his eleventh birthday, when he receives a letter of acceptance to Hogwarts School of Witchcraft and Wizardry. Harry makes close friends and a few enemies during his first year at the school and with the help of his friends, Ron Weasley and Hermione Granger, he faces an attempted comeback by the dark wizard Lord Voldemort, who killed Harry's parents but failed to kill Harry when he was just 15 months old.",
    publishDate: '1997',
    imageURL:
        'https://upload.wikimedia.org/wikipedia/en/thumb/6/6b/Harry_Potter_and_the_Philosopher%27s_Stone_Book_Cover.jpg/220px-Harry_Potter_and_the_Philosopher%27s_Stone_Book_Cover.jpg',
  ),
  BooksInfo(
    title: "Can't Hurt Me: Master Your Mind and Defy the Odds",
    autor: 'David Goggins',
    description:
        "For David Goggins, childhood was a nightmare--poverty, prejudice, and physical abuse colored his days and haunted his nights. But through self-discipline, mental toughness, and hard work, Goggins transformed himself from a depressed, overweight young man with no future into a US Armed Forces icon and one of the world's top endurance athletes. The only man in history to complete elite training as a Navy SEAL, Army Ranger, and Air Force tactical air controller, he went on to set records in numerous endurance events, inspiring Outside magazine to name him the Fittest (Real) Man in America.",
    publishDate: '2018',
    imageURL:
        'https://heritagebooks.com.np/wp-content/uploads/2022/04/cant-hurt-me.jpg',
  ),
  BooksInfo(
    title: 'Crime and Punishment',
    autor: 'Fyodor Dostoevsky',
    description:
        "Crime and Punishment (pre-reform Russian: Преступленіе и наказаніе; post-reform Russian: Преступление и наказание, romanized: Prestupleniye i nakazaniye, IPA: [prʲɪstʊˈplʲenʲɪje ɪ nəkɐˈzanʲɪje]) is a novel by the Russian author Fyodor Dostoevsky. It was first published in the literary journal The Russian Messenger in twelve monthly installments during 1866. It was later published in a single volume. It is the second of Dostoevsky's full-length novels following his return from ten years of exile in Siberia. Crime and Punishment is considered the first great novel of his mature period of writing and is often cited as one of the greatest works of world literature",
    publishDate: '1866',
    imageURL:
        'https://upload.wikimedia.org/wikipedia/en/thumb/4/4b/Crimeandpunishmentcover.png/220px-Crimeandpunishmentcover.png',
  ),
  BooksInfo(
    title: 'Steppenwolf',
    autor: 'Hermann Hesse',
    description:
        "The book is presented as a manuscript written by its protagonist, a middle-aged man named Harry Haller, who leaves it to a chance acquaintance, the nephew of his landlady. The acquaintance adds a short preface of his own and then has the manuscript published. The title of this 'real' book-within-the-book is Harry Haller's Records (For Madmen Only).",
    publishDate: '1927',
    imageURL:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Hermann_Hesse_Der_Steppenwolf_1927.jpg/220px-Hermann_Hesse_Der_Steppenwolf_1927.jpg',
  ),
  BooksInfo(
    title: 'Around the World in Eighty Days',
    autor: 'Jules Verne',
    description:
        "Around the World in Eighty Days (French: Le Tour du monde en quatre-vingts jours) is an adventure novel by the French writer Jules Verne, first published in French in 1872. In the story, Phileas Fogg of London and his newly employed French valet Passepartout attempt to circumnavigate the world in 80 days on a wager of £20,000 (equivalent to £1.9 million in 2019) set by his friends at the Reform Club. It is one of Verne's most acclaimed works",
    publishDate: '1872',
    imageURL:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/86/Verne_Tour_du_Monde.jpg/220px-Verne_Tour_du_Monde.jpg',
  ),
];
