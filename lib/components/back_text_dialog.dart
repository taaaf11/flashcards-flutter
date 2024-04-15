import 'package:flashcards/models/flashcard.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/constants.dart';

class BackTextDialog extends StatelessWidget {
  final FlashCard flashCard;

  const BackTextDialog({super.key, required this.flashCard});

  @override
  Widget build(BuildContext context) {
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
  }
}
