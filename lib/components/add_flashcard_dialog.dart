// 🐦 Flutter imports:
import 'package:flashcards/components/idea_creation_dialog_contect.dart';
import 'package:flashcards/components/qa_creation_dialog_content.dart';
import 'package:flashcards/notifiers/flashcard_details.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:flashcards/models/flashcard.dart';
import 'package:flashcards/notifiers/flashcard_type_notifier.dart';
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
  late TextEditingController _backTextEditingController;
  late TextEditingController _frontTextEditingController;
  late TextEditingController _tagsTextEditingController;
  Set<CardType> cardType = {CardType.idea};
  // ignore: prefer_final_fields
  // Difficulty _difficultyLevel = Difficulty.easy;

  @override
  void initState() {
    _backTextEditingController = TextEditingController();
    _frontTextEditingController = TextEditingController();
    _tagsTextEditingController = TextEditingController();

    if (widget.editFlashCard) {
      assert(widget.flashCardForEdit != null,
          'Flashcard is not provided for editing.');

      Provider.of<FlashCardDetailsNotifier>(context, listen: false).backText =
          widget.flashCardForEdit!.backText ?? '';
      Provider.of<FlashCardDetailsNotifier>(context, listen: false).frontText =
          widget.flashCardForEdit!.frontText;
      Provider.of<FlashCardDetailsNotifier>(context, listen: false).tags =
          widget.flashCardForEdit!.tags.join(',');
      Provider.of<FlashCardDetailsNotifier>(context, listen: false).difficulty =
          widget.flashCardForEdit!.difficulty ?? Difficulty.easy;
    }

    super.initState();
  }

  @override
  void dispose() {
    _backTextEditingController.dispose();
    _frontTextEditingController.dispose();
    _tagsTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var flashCardsListState = Provider.of<FlashCardsListProvider>(context);
    var flashCardTypeState = Provider.of<FlashCardTypeNotifier>(context);

    return AlertDialog(
      content: AnimatedSize(
        duration: const Duration(milliseconds: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              child: Consumer(
                builder: ((context, FlashCardTypeNotifier value, child) {
                  return cardType.first == CardType.qa
                      ? const QACreationForm()
                      : const IdeaCreationForm();
                }),
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
              selected: cardType,
              onSelectionChanged: (Set<CardType> newSelection) {
                setState(
                  () {
                    cardType = newSelection;
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

                if (flashCardTypeState.selection == CardType.qa &&
                    backText == '') {
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
                  backText: flashCardTypeState.selection == CardType.qa
                      ? backText
                      : null,
                  // difficulty: Provider.of<FlashCardDetailsNotifier>(context,
                  //         listen: false)
                  //     .difficulty,
                  difficulty: difficulty,
                  type: flashCardTypeState.selection,
                  tags: tags,
                );

                if (widget.editFlashCard) {
                  flashCardsListState.insert(
                      removedIndex!, widget.flashCardForEdit!);
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
