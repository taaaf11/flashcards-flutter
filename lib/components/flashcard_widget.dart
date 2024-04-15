import 'package:flashcards/constants.dart';
import 'package:flashcards/flashcard_repository/flashcard_repository.dart';
import 'package:flashcards/notifiers/flashcards_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/models/flashcard.dart';
import 'package:provider/provider.dart';

class FlashCardWidget extends StatelessWidget {
  final FlashCard flashCard;

  const FlashCardWidget({super.key, required this.flashCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: switch (flashCard.difficulty) {
          1 => kPrimaryColor.withAlpha(58),
          2 => Colors.orange.withAlpha(58),
          3 => Colors.red.withAlpha(58),
          _ => Colors.transparent
        },
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (flashCard.backText == null) return;
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    'The Answer is:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  content: Text(
                    flashCard.backText!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kPrimaryColor.withOpacity(0.9),
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              },
            );
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                Text(
                  flashCard.frontText,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline_rounded, size: 16),
                  onPressed: () {
                    FlashCardsRepository.removeFlashCard(flashCard);
                    Provider.of<FlashCardsListProvider>(context, listen: false)
                        .remove(flashCard);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
