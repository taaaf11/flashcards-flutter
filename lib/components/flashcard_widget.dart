import 'package:flashcards/components/back_text_dialog.dart';
import 'package:flashcards/constants.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/models/flashcard.dart';

// TODO: Add longPress function for supplying editing and deletion commands
class FlashCardWidget extends StatelessWidget {
  final FlashCard flashCard;

  const FlashCardWidget({super.key, required this.flashCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: switch (flashCard.difficulty) {
          1 => kPrimaryColor.withAlpha(125),
          2 => Colors.orange.withAlpha(125),
          3 => Colors.red.withAlpha(125),
          null => Colors.yellow.withAlpha(125),
          _ => Colors.transparent,
        },
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          hoverDuration: const Duration(milliseconds: 20),
          splashColor: Theme.of(context).splashColor.withOpacity(0.1),
          onTap: () {
            if (flashCard.backText == null) return;
            showDialog(
              context: context,
              builder: (context) {
                return BackTextDialog(flashCard: flashCard);
              },
            );
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    flashCard.frontText,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Icon(
                    flashCard.difficulty != null
                        ? Icons.question_mark_rounded
                        : Icons.lightbulb_outline_rounded,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
