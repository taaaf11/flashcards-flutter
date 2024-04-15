import 'package:flashcards/notifiers/flashcards_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/models/flashcard.dart';
import 'package:flashcards/flashcard_repository/flashcard_repository.dart';
import 'package:provider/provider.dart';

enum CardType { idea, qa } // TODO: Change the name of enum!!

class AddFlashCardDialog extends StatefulWidget {
  const AddFlashCardDialog({super.key});

  @override
  State<AddFlashCardDialog> createState() => _AddFlashCardDialogState();
}

class _AddFlashCardDialogState extends State<AddFlashCardDialog> {
  // late TextEditingController _titleEditingController;
  late TextEditingController _backTextEditingController;
  late TextEditingController _frontTextEditingController;
  double _difficultyLevel = 1; // easy

  CardType cardType = CardType.idea;

  @override
  void initState() {
    // _titleEditingController = TextEditingController();
    _backTextEditingController = TextEditingController();
    _frontTextEditingController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    // _titleEditingController.dispose();
    _backTextEditingController.dispose();
    _frontTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var flashCardsState = Provider.of<FlashCardsListProvider>(context);

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(cardType == CardType.idea ? 'Idea:' : 'Question',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                width: 110,
                child: TextField(
                  controller: _frontTextEditingController,
                  maxLength: 255,
                ),
              ),
            ],
          ),
          cardType == CardType.qa
              ? Row(
                  children: [
                    const Expanded(
                      child: Text('Answer:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                        width: 110,
                        child: TextField(
                            controller: _backTextEditingController,
                            maxLength: 255)),
                  ],
                )
              : const SizedBox.shrink(),
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
          Row(children: [
            Text('Difficulty:',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w800)),
            Slider(
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
                _ => ''
              },
              divisions: 2,
            )
          ])
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.check),
          onPressed: () {
            setState(() {
              if (_backTextEditingController.text == '' &&
                  _frontTextEditingController.text == '') {
                Navigator.of(context).pop();
                return;
              }

              FlashCard flashCard = FlashCard(
                timeOfCreation: DateTime.now().toIso8601String(),
                frontText: _frontTextEditingController.text,
                backText: cardType == CardType.qa
                    ? _backTextEditingController.text
                    : null,
                difficulty: _difficultyLevel,
              );

              FlashCardsRepository.insertFlashCard(flashCard);
              flashCardsState.add(flashCard);

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
