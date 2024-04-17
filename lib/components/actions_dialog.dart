import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flashcards/components/add_flashcard_dialog.dart';
import 'package:flashcards/models/flashcard.dart';
import 'package:flashcards/notifiers/flashcards_notifier.dart';
import 'icon_text_button.dart';

class ActionsDialog extends StatelessWidget {
  final FlashCard flashCard;

  const ActionsDialog({super.key, required this.flashCard});

  @override
  Widget build(BuildContext context) {
    FlashCardsListProvider flashCardsListProvider =
        Provider.of<FlashCardsListProvider>(context);

    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconTextButton(
            icon: Icons.edit_rounded,
            child: const Text('Edit'),
            onPress: () {
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (context) {
                  return AddFlashCardDialog(
                    editFlashCard: true,
                    flashCardForEdit: flashCard,
                  );
                },
              );
            },
          ),
          IconTextButton(
            icon: Icons.delete_rounded,
            child: const Text('Delete'),
            onPress: () {
              flashCardsListProvider.remove(flashCard);
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
