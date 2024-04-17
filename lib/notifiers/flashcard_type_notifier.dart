// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:flashcards/types.dart';

class FlashCardTypeNotifier with ChangeNotifier {
  Set<CardType> _set = {CardType.idea};

  void changeSelection(CardType cardType) {
    _set = {cardType};
    notifyListeners();
  }

  Set<CardType> get set => _set;
  CardType get selection => _set.first;
}
