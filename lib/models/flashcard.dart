// 🌎 Project imports:
import 'package:flashcards/types.dart';

class FlashCard {
  FlashCard({
    required this.timeOfCreation,
    required this.frontText,
    this.backText,
    this.difficulty,
    required this.type,
    required this.tags,
  });

  String timeOfCreation;
  String frontText; // previously: question
  String? backText; // previously: answer
  Difficulty? difficulty; // null when user selects an idea
  CardType type;
  List<String> tags;

  factory FlashCard.fromMap(Map<String, dynamic> map) {
    return FlashCard(
      timeOfCreation: map['timeOfCreation'] as String,
      frontText: map['frontText'] as String,
      backText: map['backText'] as String?,
      difficulty: map['difficulty'] as Difficulty?,
      type: map['type'] as CardType,
      tags: map['tags'] as List<String>,
    );
  }

  Map<String, Object?> toMap() => {
        'timeOfCreation': timeOfCreation,
        'frontText': frontText,
        'backText': backText,
        'difficulty': difficulty,
        'type': type,
        'tags': tags,
      };

  // Implement toString to make it easier to see information about
  // each flashcard when using the print statement.
  @override
  String toString() {
    return 'FlashCard(timeOfCreation: "$timeOfCreation", '
        'frontText: "$frontText", '
        'backText: ${backText == null ? null : "\"$backText\""}, '
        'difficulty: $difficulty, '
        'type: $type, '
        'tags: $tags,'
        ')';
  }
}
