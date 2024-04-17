import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flashcards/notifiers/flashcards_notifier.dart';
import 'package:flashcards/components/flashcard_widget.dart';

class FlashCardsPage extends StatelessWidget {
  const FlashCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var flashCardsState = Provider.of<FlashCardsListProvider>(context);

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 18),
            itemCount: flashCardsState.flashCards.length,
            itemBuilder: (context, index) {
              return FlashCardWidget(
                flashCard: flashCardsState.flashCards[index],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 12),
          ),
        ),
      ],
    );
  }
}
