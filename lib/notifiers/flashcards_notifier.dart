// 🐦 Flutter imports:
import 'package:flashcards/components/flashcard_widget.dart';
import 'package:flashcards/notifiers/flashcards_animatedlist_key.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:flashcards/flashcard_repository/flashcards_repository.dart';
import 'package:flashcards/models/flashcard.dart';

class FlashCardsListProvider with ChangeNotifier {
  late List<FlashCard> _flashCards;

  FlashCardsListProvider(List<FlashCard>? flashCards) {
    _flashCards = flashCards ?? [];
  }

  void add(FlashCard flashCard) {
    FlashCardsAnimatedListKeyProvider.listeState?.insertItem(_flashCards.length,
        duration: const Duration(milliseconds: 500));
    _flashCards.add(flashCard);
    FlashCardsRepository.insertFlashCard(flashCard);
    notifyListeners();
  }

  void remove(FlashCard flashCard) {
    int index = _flashCards.indexOf(flashCard);

    FlashCardsRepository.removeFlashCard(flashCard);
    FlashCard removed = _flashCards.removeAt(index);

    FlashCardsAnimatedListKeyProvider.key?.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: FlashCardWidget(
          flashCard: removed,
        ),
      ),
      duration: const Duration(milliseconds: 250),
    );

    notifyListeners();
  }

  void removeAt(int index) {
    FlashCard removed = _flashCards.removeAt(index);

    FlashCardsRepository.removeFlashCard(removed);
    notifyListeners();
  }

  List<FlashCard> get flashCards => _flashCards;
}
