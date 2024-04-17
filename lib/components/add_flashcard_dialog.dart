import 'package:flashcards/components/flashcard_type.dart';
import 'package:flashcards/notifiers/flashcard_type_notifier.dart';
import 'package:flashcards/notifiers/flashcards_notifier.dart';
import 'package:flashcards/types.dart';
import 'package:flashcards/validations.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/models/flashcard.dart';
import 'package:provider/provider.dart';

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
  Difficulty _difficultyLevel = Difficulty.easy; // easy

  // CardType cardType = CardType.idea;

  @override
  void initState() {
    _backTextEditingController = TextEditingController();
    _frontTextEditingController = TextEditingController();
    _tagsTextEditingController = TextEditingController();

    if (widget.editFlashCard) {
      assert(widget.flashCardForEdit != null,
          'Flashcard is not provided for editing.');
      _backTextEditingController.text = widget.flashCardForEdit!.backText ?? '';
      _frontTextEditingController.text = widget.flashCardForEdit!.frontText;
      _tagsTextEditingController.text = widget.flashCardForEdit!.tags.join(',');
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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  flashCardTypeState.selection == CardType.idea
                      ? 'Idea:'
                      : 'Question',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 110,
                child: TextField(
                  controller: _frontTextEditingController,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          flashCardTypeState.selection == CardType.qa
              ? Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Answer:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 110,
                      child: TextField(
                        controller: _backTextEditingController,
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
          flashCardTypeState.selection == CardType.qa
              ? const SizedBox(height: 30)
              : const SizedBox.shrink(),
          flashCardTypeState.selection == CardType.qa
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Difficulty:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 110,
                      child: Slider(
                        onChanged: (double? value) {
                          setState(() {
                            _difficultyLevel = switch (value) {
                              1 => Difficulty.easy,
                              2 => Difficulty.medium,
                              3 => Difficulty.hard,
                              _ => Difficulty.hard,
                            };
                          });
                        },
                        value: _difficultyLevel.index + 1,
                        min: 1,
                        max: 3,
                        label: switch (_difficultyLevel) {
                          Difficulty.easy => 'Easy',
                          Difficulty.medium => 'Medium',
                          Difficulty.hard => 'Hard',
                        },
                        divisions: 2,
                      ),
                    )
                  ],
                )
              : const SizedBox.shrink(),
          flashCardTypeState.selection == CardType.qa
              ? const SizedBox(height: 20)
              : const SizedBox.shrink(),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Tags:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 110,
                child: TextField(
                  controller: _tagsTextEditingController,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const FlashCardType()
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.check),
          onPressed: () {
            String frontText = _frontTextEditingController.text;
            String backText = _backTextEditingController.text;
            String tagsString = _tagsTextEditingController.text;

            setState(
              () {
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
                  flashCardsListState.remove(widget.flashCardForEdit!);
                }

                List<String> tags = getTagsFromTagsString(tagsString);

                FlashCard flashCard = FlashCard(
                  timeOfCreation: DateTime.now().toIso8601String(),
                  frontText: frontText,
                  backText: flashCardTypeState.selection == CardType.qa
                      ? backText
                      : null,
                  difficulty: flashCardTypeState.selection == CardType.qa
                      ? _difficultyLevel
                      : null,
                  type: flashCardTypeState.selection,
                  tags: tags,
                );

                flashCardsListState.add(flashCard);

                Navigator.of(context).pop();
              },
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
