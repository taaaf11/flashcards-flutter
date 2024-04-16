import 'package:flashcards/models/flashcard.dart';
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
                'The Question is: ',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 5),
              Text(
                flashCard.frontText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: kPrimaryColor.withOpacity(0.9),
                    ),
              ),
            ],
          ),
          SizedBox(height: 18),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'The Answer is: ',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 5),
              Text(
                flashCard.backText!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: kPrimaryColor.withOpacity(0.9),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
