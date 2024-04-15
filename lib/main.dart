import 'package:flashcards/components/add_flashcard_dialog.dart';
import 'package:flashcards/components/flashcard_widget.dart';
import 'package:flashcards/constants.dart';
import 'package:flashcards/notifiers/flashcards_notifier.dart';

import 'package:flutter/material.dart';
import 'package:flashcards/flashcard_repository/flashcard_repository.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter('flashcards_dir');
  await Hive.openBox('Flashcards');

  FlashCardsRepository.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          FlashCardsListProvider(FlashCardsRepository.getFlashCards()),
      child: MaterialApp(
        title: 'FlashCards',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: kPrimaryColor,
            // brightness: Brightness.dark,
          ),
          // fontFamily: 'OpenSans-Regular',
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FlashCardsListProvider flashCards;

  @override
  void initState() {
    super.initState();
    flashCards = Provider.of<FlashCardsListProvider>(context, listen: false);
  }

  void _showAddFlashCardDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const AddFlashCardDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var flashCardsState = Provider.of<FlashCardsListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: flashCardsState.flashCards.length,
              itemBuilder: (context, index) {
                return FlashCardWidget(
                  flashCard: flashCardsState.flashCards[index],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 12),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddFlashCardDialog,
        tooltip: 'Add flashcard',
        child: const Icon(Icons.add, color: kPrimaryColor),
      ),
    );
  }
}
