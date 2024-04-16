import 'package:flashcards/notifiers/flashcards_notifier.dart';
import 'package:flashcards/validations.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/models/flashcard.dart';
import 'package:provider/provider.dart';

enum CardType { idea, qa } // TODO: Change the name of enum!!

// ignore: must_be_immutable
class AddFlashCardDialog extends StatefulWidget {
  bool? editFlashCard;
  FlashCard? flashCardForEdit;

  AddFlashCardDialog({super.key, this.editFlashCard, this.flashCardForEdit});

  @override
  State<AddFlashCardDialog> createState() => _AddFlashCardDialogState();
}

class _AddFlashCardDialogState extends State<AddFlashCardDialog> {
  late TextEditingController _backTextEditingController;
  late TextEditingController _frontTextEditingController;
  late TextEditingController _tagsTextEditingController;
  double _difficultyLevel = 1; // easy

  CardType cardType = CardType.idea;

  @override
  void initState() {
    _backTextEditingController = TextEditingController();
    _frontTextEditingController = TextEditingController();
    _tagsTextEditingController = TextEditingController();

    if (widget.editFlashCard != null) {
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

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  cardType == CardType.idea ? 'Idea:' : 'Question',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 110,
                child: TextField(
                  controller: _frontTextEditingController,
                  decoration: InputDecoration(border: UnderlineInputBorder()),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          cardType == CardType.qa
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
          cardType == CardType.qa ? SizedBox(height: 30) : SizedBox.shrink(),
          cardType == CardType.qa
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
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
                            _difficultyLevel = value!;
                          });
                        },
                        value: _difficultyLevel,
                        min: 1,
                        max: 3,
                        label: switch (_difficultyLevel) {
                          1 => 'Easy',
                          2 => 'Medium',
                          3 => 'Hard',
                          _ => null
                        },
                        divisions: 2,
                      ),
                    )
                  ],
                )
              : const SizedBox.shrink(),
          cardType == CardType.qa ? SizedBox(height: 20) : SizedBox.shrink(),
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
          SizedBox(height: 20),
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
              setState(() {
                cardType = newSelection.first;
              });
            },
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.check),
          onPressed: () {
            String frontText = _frontTextEditingController.text;
            String backText = _backTextEditingController.text;
            String tagsString = _tagsTextEditingController.text;

            // print('sldjkflsjflsj');

            setState(() {
              if (!isFrontTextNotEmpty(frontText)) {
                Navigator.of(context).pop();
                return;
              }

              List<String> tags = getTagsFromTagsString(tagsString);

              FlashCard flashCard = FlashCard(
                timeOfCreation: DateTime.now().toIso8601String(),
                frontText: frontText,
                backText: cardType == CardType.qa ? backText : null,
                difficulty: cardType == CardType.qa ? _difficultyLevel : null,
                tags: tags,
              );

              flashCardsListState.add(flashCard);

              Navigator.of(context).pop();
            });
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
