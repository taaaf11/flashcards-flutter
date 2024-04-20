// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:flashcards/components/idea_creation_dialog_contect.dart';
import 'package:flashcards/components/qa_creation_dialog_content.dart';
import 'package:flashcards/models/flashcard.dart';
import 'package:flashcards/notifiers/flashcard_details.dart';
import 'package:flashcards/notifiers/flashcards_notifier.dart';
import 'package:flashcards/types.dart';
import 'package:flashcards/utils.dart';

// ignore: must_be_immutable
class AddFlashCardDialog extends StatefulWidget {
  bool editFlashCard;
  FlashCard? flashCardForEdit;

  AddFlashCardDialog({
    super.key,
    this.editFlashCard = false,
    this.flashCardForEdit,
  });

  @override
  State<AddFlashCardDialog> createState() => _AddFlashCardDialogState();
}

class _AddFlashCardDialogState extends State<AddFlashCardDialog> {
  CardType cardType = CardType.idea;

  @override
  void initState() {
    if (widget.editFlashCard) {
      assert(widget.flashCardForEdit != null);
      cardType = widget.flashCardForEdit!.type;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var flashCardsListState = Provider.of<FlashCardsListProvider>(context);

    return AlertDialog(
      content: AnimatedSize(
        duration: const Duration(milliseconds: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              child: cardType == CardType.qa
                  ? QACreationForm(
                      editFlashCard: widget.editFlashCard,
                      flashCardForEdit: widget.flashCardForEdit,
                    )
                  : IdeaCreationForm(
                      editFlashCard: widget.editFlashCard,
                      flashCardForEdit: widget.flashCardForEdit,
                    ),
            ),
            const SizedBox(height: 20),
            SegmentedButton<CardType>(
              segments: const <ButtonSegment<CardType>>[
                ButtonSegment(
                  value: CardType.idea,
                  label: Text('Idea'),
                  icon: Icon(Icons.lightbulb_outline_rounded),
                ),
                ButtonSegment(
                  value: CardType.qa,
                  label: Text('Q/A'),
                  icon: Icon(Icons.question_mark_outlined),
                )
              ],
              selected: <CardType>{cardType},
              onSelectionChanged: (Set<CardType> newSelection) {
                setState(
                  () {
                    cardType = newSelection.first;
                  },
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.check_rounded),
          onPressed: () {
            String frontText =
                Provider.of<FlashCardDetailsNotifier>(context, listen: false)
                    .frontText!;
            String backText =
                Provider.of<FlashCardDetailsNotifier>(context, listen: false)
                        .backText ??
                    '';
            String tagsString =
                Provider.of<FlashCardDetailsNotifier>(context, listen: false)
                        .tags ??
                    '';
            Difficulty? difficulty =
                Provider.of<FlashCardDetailsNotifier>(context, listen: false)
                    .difficulty;

            setState(
              () {
                int? removedIndex;

                if (frontText.isEmpty) {
                  Navigator.of(context).pop();
                  return;
                }

                if (cardType == CardType.qa && backText == '') {
                  Navigator.of(context).pop();
                  return;
                }

                if (widget.editFlashCard) {
                  removedIndex =
                      flashCardsListState.remove(widget.flashCardForEdit!);
                }

                List<String> tags = getTagsFromTagsString(tagsString);

                FlashCard flashCard = FlashCard(
                  timeOfCreation: DateTime.now().toIso8601String(),
                  frontText: frontText,
                  backText: cardType == CardType.qa ? backText : null,
                  difficulty: difficulty,
                  type: cardType,
                  tags: tags,
                );

                if (widget.editFlashCard) {
                  flashCardsListState.insert(removedIndex!, flashCard);
                } else {
                  flashCardsListState.add(flashCard);
                }

                Navigator.of(context).pop();
              },
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.cancel_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
