// 📦 Package imports:
import 'package:hive/hive.dart';

// 🌎 Project imports:
import 'package:flashcards/models/flashcard.dart';

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

    var resultValues =
        result.values.toList().map((e) => FlashCard.fromMap(e)).toList();

    resultValues.sort((a, b) {
      String timeOfCreationOfA = a.timeOfCreation;
      String timeOfCreationOfB = b.timeOfCreation;
      return timeOfCreationOfA.compareTo(timeOfCreationOfB);
    });

    return resultValues;
  }
}
