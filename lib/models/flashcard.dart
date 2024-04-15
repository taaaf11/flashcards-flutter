class FlashCard {
  FlashCard(
      {required this.timeOfCreation,
      required this.title,
      required this.question,
      required this.answer});

  String timeOfCreation;
  String title;
  String question;
  String answer;

  factory FlashCard.fromMap(Map<String, dynamic> map) {
    return FlashCard(
      timeOfCreation: map['timeOfCreation'] as String,
      title: map['title'] as String,
      question: map['question'] as String,
      answer: map['answer'] as String,
    );
  }

  Map<String, Object> toMap() => {
        'timeOfCreation': timeOfCreation,
        'title': title,
        'question': question,
        'answer': answer
      };

  // Implement toString to make it easier to see information about
  // each flashcard when using the print statement.
  @override
  String toString() {
    return 'FlashCard{timeOfCreation: $timeOfCreation, title: $title, question: $question, answer: $answer}';
  }
}
