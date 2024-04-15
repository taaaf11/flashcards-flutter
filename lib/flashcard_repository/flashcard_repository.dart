import 'package:flashcards/models/flashcard.dart';
import 'package:hive/hive.dart';

class FlashCardsRepository {
  static late final Box box;
  static bool _isInitialized = false;

  static void initialize() async {
    box = Hive.box('Flashcards');
    _isInitialized = true;
  }

  static void insertFlashCard(FlashCard flashCard) {
    if (!_isInitialized) initialize();

    box.put(flashCard.timeOfCreation, flashCard.toMap());
  }

  static void removeFlashCard(FlashCard flashCard) {
    if (!_isInitialized) initialize();

    box.delete(flashCard.timeOfCreation);
  }

  static List<FlashCard> getFlashCards() {
    final result = box.toMap().map(
          (k, e) => MapEntry(
            k.toString(),
            Map<String, dynamic>.from(e),
          ),
        );

    return result.values.map((e) => FlashCard.fromMap(e)).toList();
  }
}
