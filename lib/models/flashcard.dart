class FlashCard {
  FlashCard({
    required this.timeOfCreation,
    required this.frontText,
    this.backText,
    this.difficulty,
    required this.tags,
  });

  String timeOfCreation;
  String frontText; // previously: question
  String? backText; // previously: answer
  double? difficulty; // null when user selects an idea
  List<String> tags;

  factory FlashCard.fromMap(Map<String, dynamic> map) {
    return FlashCard(
      timeOfCreation: map['timeOfCreation'] as String,
      frontText: map['frontText'] as String,
      backText: map['backText'] as String?,
      difficulty: map['difficulty'] as double?,
      tags: map['tags'] as List<String>,
    );
  }

  Map<String, Object?> toMap() => {
        'timeOfCreation': timeOfCreation,
        'frontText': frontText,
        'backText': backText,
        'difficulty': difficulty,
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
        'tags: $tags,'
        ')';
  }
}
