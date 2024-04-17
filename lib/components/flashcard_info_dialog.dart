import 'package:flashcards/models/flashcard.dart';
import 'package:flashcards/types.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/constants.dart';

class FlashCardInfoDialog extends StatelessWidget {
  final FlashCard flashCard;

  const FlashCardInfoDialog({super.key, required this.flashCard});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                flashCard.type == CardType.qa ? 'Question:' : 'Idea',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                flashCard.frontText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: kPrimaryColor.withOpacity(0.9),
                    ),
              ),
            ],
          ),
          flashCard.type == CardType.qa && flashCard.backText != null
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 18),
                    Text(
                      'Answer:',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      flashCard.backText!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: kPrimaryColor.withOpacity(0.9),
                          ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
