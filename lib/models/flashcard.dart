class FlashCard {
  FlashCard({
    required this.timeOfCreation,
    // required this.title,
    required this.frontText,
    this.backText,
    this.difficulty,
  });

  String timeOfCreation;
  // String title;
  String frontText; // previously: question
  String? backText; // previously: answer
  double? difficulty; // null when user selects an idea

  factory FlashCard.fromMap(Map<String, dynamic> map) {
    return FlashCard(
      timeOfCreation: map['timeOfCreation'] as String,
      // title: map['title'] as String,
      frontText: map['frontText'] as String,
      backText: map['backText'] as String?,
      difficulty: map['difficulty'] as double?,
    );
  }

  Map<String, Object?> toMap() => {
        'timeOfCreation': timeOfCreation,
        // 'title': title,
        'frontText': frontText,
        'backText': backText,
        'difficulty': difficulty,
      };

  // Implement toString to make it easier to see information about
  // each flashcard when using the print statement.
  @override
  String toString() {
    return 'FlashCard{timeOfCreation: $timeOfCreation, '
        // 'title: $title, '
        'frontText: $frontText, '
        'backText: $backText, '
        'difficulty: $difficulty}';
  }
}
