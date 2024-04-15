import 'package:flashcards/models/flashcard.dart';
import 'package:flutter/material.dart';

class FlashCardsListProvider with ChangeNotifier {
  late List<FlashCard> _flashCards;

  FlashCardsListProvider(List<FlashCard>? flashCards) {
    _flashCards = flashCards ?? [];
  }

  void add(FlashCard flashCard) {
    _flashCards.add(flashCard);
    notifyListeners();
  }

  void remove(FlashCard flashCard) {
    _flashCards.remove(flashCard);
    notifyListeners();
  }

  List<FlashCard> get flashCards => _flashCards;
}
