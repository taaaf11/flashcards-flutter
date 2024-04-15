import 'package:flashcards/notifiers/flashcards_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/models/flashcard.dart';
import 'package:flashcards/flashcard_repository/flashcard_repository.dart';
import 'package:provider/provider.dart';

enum Difficulty { easy, medium, hard }

class AddFlashCardDialog extends StatefulWidget {
  const AddFlashCardDialog({super.key});

  @override
  State<AddFlashCardDialog> createState() => _AddFlashCardDialogState();
}

class _AddFlashCardDialogState extends State<AddFlashCardDialog> {
  late TextEditingController _titleEditingController;
  late TextEditingController _questionEditingController;
  late TextEditingController _answerEditingController;
  double _difficultyLevel = 1; // easy

  @override
  void initState() {
    _titleEditingController = TextEditingController();
    _questionEditingController = TextEditingController();
    _answerEditingController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _questionEditingController.dispose();
    _answerEditingController.dispose();

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
              const Expanded(
                child: Text('Title:',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                width: 110,
                child: TextField(
                  controller: _titleEditingController,
                  maxLength: 255,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                child: Text('Question:',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                width: 110,
                child: TextField(
                  controller: _questionEditingController,
                  maxLength: 255,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                child: Text('Answer:',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                  width: 110,
                  child: TextField(
                      controller: _answerEditingController, maxLength: 255)),
            ],
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
              if (_titleEditingController.text == '' &&
                  _questionEditingController.text == '' &&
                  _answerEditingController.text == '') {
                Navigator.of(context).pop();
                return;
              }

              FlashCard flashCard = FlashCard(
                timeOfCreation: DateTime.now().toIso8601String(),
                title: _titleEditingController.text,
                question: _questionEditingController.text,
                answer: _answerEditingController.text,
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
