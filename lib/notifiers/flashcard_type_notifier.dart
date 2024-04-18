// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:flashcards/types.dart';

class FlashCardTypeNotifier with ChangeNotifier {
  Set<CardType> set = {CardType.idea};

  void changeSelection(CardType cardType) {
    set = {cardType};
    notifyListeners();
  }

  Set<CardType> get set_ => set;
  CardType get selection => set.first;
}
