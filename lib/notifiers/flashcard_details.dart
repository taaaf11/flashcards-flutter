// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:flashcards/types.dart';

class FlashCardDetailsNotifier with ChangeNotifier {
  String? frontText;
  String? backText;
  String? tags;
  Difficulty? difficulty;

  FlashCardDetailsNotifier();
}
