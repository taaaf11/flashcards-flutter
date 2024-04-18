import 'package:flashcards/types.dart';
import 'package:flutter/material.dart';

class FlashCardDetailsNotifier with ChangeNotifier {
  String? frontText;
  String? backText;
  String? tags;
  Difficulty? difficulty;

  FlashCardDetailsNotifier();
}
