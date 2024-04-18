// 🐦 Flutter imports:
import 'package:flashcards/models/flashcard.dart';
import 'package:flashcards/notifiers/flashcards_animatedlist_key.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:flashcards/components/add_flashcard_dialog.dart';
import 'package:flashcards/constants.dart';
import 'package:flashcards/flashcard_repository/flashcards_repository.dart';
import 'package:flashcards/notifiers/flashcard_type_notifier.dart';
import 'package:flashcards/notifiers/flashcards_notifier.dart';
import 'package:flashcards/pages/about_page.dart';
import 'package:flashcards/pages/flashcards_page.dart';
import 'package:flashcards/pages/settings_page.dart';
import 'package:flashcards/types.dart';

void main() async {
  await Hive.initFlutter('flashcards_dir');

  Hive
    ..registerAdapter(CardTypeAdapter())
    ..registerAdapter(DifficultyAdapter());

  await Hive.openBox('Flashcards');

  FlashCardsRepository.initialize();
  FlashCardsAnimatedListKeyProvider.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              FlashCardsListProvider(FlashCardsRepository.getFlashCards()),
        ),
        ChangeNotifierProvider(create: (_) => FlashCardTypeNotifier()),
      ],
      child: AdaptiveTheme(
        light: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: kPrimaryColor,
            brightness: Brightness.light,
          ),
          fontFamily: 'Comfortaa',
          useMaterial3: true,
        ),
        dark: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: kPrimaryColor,
            brightness: Brightness.dark,
          ),
          fontFamily: 'Comfortaa',
          useMaterial3: true,
        ),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp(
          title: 'FlashCards',
          theme: theme,
          darkTheme: darkTheme,
          home: const MyHomePage(title: 'Flashcards'),
        ),
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
  int _currentPage = 0;
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
    AdaptiveThemeMode currentThemeMode = AdaptiveTheme.of(context).mode;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(
              currentThemeMode == AdaptiveThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () => currentThemeMode == AdaptiveThemeMode.light
                ? AdaptiveTheme.of(context).setDark()
                : AdaptiveTheme.of(context).setLight(),
          )
        ],
      ),
      body: switch (_currentPage) {
        0 => const FlashCardsPage(),
        1 => const SettingsPage(),
        2 => const AboutPage(),
        _ => null
      },
      drawer: NavigationDrawer(
        onDestinationSelected: (int? destIndex) {
          setState(() {
            assert(destIndex != null, 'Unknown page: $destIndex');

            _currentPage = destIndex!;

            // close the drawer; it doesn't automatically
            Navigator.of(context).pop();
          });
        },
        selectedIndex: _currentPage,
        children: const [
          NavigationDrawerDestination(
            icon: Icon(Icons.home_outlined),
            label: Text('Home'),
            selectedIcon: Icon(Icons.home_rounded),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.settings_outlined),
            label: Text('Settings'),
            selectedIcon: Icon(Icons.settings_rounded),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.info_outline_rounded),
            label: Text('About'),
            selectedIcon: Icon(Icons.info_rounded),
          )
        ],
      ),
      floatingActionButton: Visibility(
        visible: _currentPage == 0,
        child: FloatingActionButton(
          onPressed: _showAddFlashCardDialog,
          tooltip: 'Add flashcard',
          shape: const CircleBorder(),
          child: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}
