import 'package:flashcards/components/add_flashcard_dialog.dart';
import 'package:flashcards/components/flashcard_widget.dart';
import 'package:flashcards/constants.dart';
import 'package:flashcards/models/flashcard.dart';
import 'package:flashcards/notifiers/flashcards_notifier.dart';
import 'package:flashcards/types.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flashcards/flashcard_repository/flashcard_repository.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter('flashcards_dir');

  Hive
    ..registerAdapter(CardTypeAdapter())
    ..registerAdapter(DifficultyAdapter());

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
          fontFamily: 'Comfortaa',
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flashcards'),
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
  late FlashCardsListProvider flashCardsListProvider;

  @override
  void initState() {
    super.initState();
    flashCardsListProvider =
        Provider.of<FlashCardsListProvider>(context, listen: false);
  }

  void _showAddFlashCardDialog() {
    if (kDebugMode && flashCardsListProvider.flashCards.isEmpty) {
      flashCardsListProvider.add(FlashCard(
        timeOfCreation: "2024-04-16T19:46:03.908",
        frontText: "Easy",
        backText: "easy",
        difficulty: Difficulty.easy,
        type: CardType.qa,
        tags: [],
      ));
      flashCardsListProvider.add(FlashCard(
        timeOfCreation: "2024-04-16T19:45:41.944",
        frontText: "Medium",
        backText: "medium",
        difficulty: Difficulty.medium,
        type: CardType.qa,
        tags: [],
      ));
      flashCardsListProvider.add(FlashCard(
        timeOfCreation: "2024-04-16T19:46:21.471",
        frontText: "Hard",
        backText: "hard",
        difficulty: Difficulty.hard,
        type: CardType.qa,
        tags: [],
      ));
      flashCardsListProvider.add(FlashCard(
        timeOfCreation: "2024-04-16T19:46:21.471",
        frontText: "Easy (but without answer i.e. backText)",
        backText: null,
        difficulty: Difficulty.easy,
        type: CardType.qa,
        tags: [],
      ));
      flashCardsListProvider.add(FlashCard(
        timeOfCreation: "2024-04-16T19:37:53.603",
        frontText: "Idea",
        backText: null,
        difficulty: null,
        type: CardType.idea,
        tags: ['idea', 'an idea'],
      ));
      return;
    }
    showDialog(
      context: context,
      builder: (context) {
        return AddFlashCardDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var flashCardsState = Provider.of<FlashCardsListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 18),
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
