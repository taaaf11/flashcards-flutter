// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:provider/provider.dart';

// 🌎 Project imports:
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconTextButton(
            icon: const Icon(Icons.edit_rounded),
            borderRadius: BorderRadius.circular(12),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            spacing: 10,
            child: const Text('Edit'),
            onPress: () {
              Navigator.of(context).pop();
              showGeneralDialog(
                barrierDismissible: true,
                barrierLabel: 'Add Flashcard dialog',
                context: context,
                pageBuilder: (context, animation, secondaryAnimation) {
                  return AddFlashCardDialog(
                    editFlashCard: true,
                    flashCardForEdit: flashCard,
                  );
                },
                transitionBuilder:
                    (context, animation, secondaryAnimation, child) {
                  Tween<Offset> tween;

                  if (animation.status == AnimationStatus.reverse) {
                    tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
                  } else {
                    tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
                  }

                  return SlideTransition(
                    position: tween.animate(animation),
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 400),
              );
            },
          ),
          IconTextButton(
            icon: const Icon(Icons.delete_rounded),
            borderRadius: BorderRadius.circular(12),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            spacing: 10,
            onPress: () {
              flashCardsListProvider.remove(flashCard);

              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          )
        ],
      ),
    );
  }
}
