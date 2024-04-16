import 'package:flashcards/flashcard_repository/flashcard_repository.dart';
import 'package:flashcards/models/flashcard.dart';
import 'package:flutter/material.dart';

class FlashCardsListProvider with ChangeNotifier {
  late List<FlashCard> _flashCards;

  FlashCardsListProvider(List<FlashCard>? flashCards) {
    _flashCards = flashCards ?? [];
  }

  void add(FlashCard flashCard) {
    _flashCards.add(flashCard);
    FlashCardsRepository.insertFlashCard(flashCard);
    notifyListeners();
  }

  void remove(FlashCard flashCard) {
    _flashCards.remove(flashCard);
    FlashCardsRepository.removeFlashCard(flashCard);
    notifyListeners();
  }

  List<FlashCard> get flashCards => _flashCards;
}
