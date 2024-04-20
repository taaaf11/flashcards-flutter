// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:flashcards/models/flashcard.dart';
import 'package:flashcards/notifiers/flashcard_details.dart';
import 'package:flashcards/types.dart';

class QACreationForm extends StatefulWidget {
  final bool editFlashCard;
  final FlashCard? flashCardForEdit;

  const QACreationForm({
    super.key,
    this.editFlashCard = false,
    this.flashCardForEdit,
  });

  @override
  State<QACreationForm> createState() => _QACreationFormState();
}

class _QACreationFormState extends State<QACreationForm> {
  late TextEditingController _frontTextEditingController;
  late TextEditingController _backTextEditingController;
  late TextEditingController _tagsTextEditingController;

  @override
  void initState() {
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

    _frontTextEditingController = TextEditingController(
        text: Provider.of<FlashCardDetailsNotifier>(context, listen: false)
            .frontText);
    _backTextEditingController = TextEditingController(
        text: Provider.of<FlashCardDetailsNotifier>(context, listen: false)
            .backText);
    _tagsTextEditingController = TextEditingController(
        text:
            Provider.of<FlashCardDetailsNotifier>(context, listen: false).tags);

    super.initState();
  }

  @override
  void dispose() {
    _frontTextEditingController.dispose();
    _backTextEditingController.dispose();
    _tagsTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Question:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 110,
              child: TextField(
                controller: _frontTextEditingController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (String value) {
                  Provider.of<FlashCardDetailsNotifier>(context, listen: false)
                      .frontText = value;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Answer:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 110,
              child: TextField(
                controller: _backTextEditingController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (String value) {
                  Provider.of<FlashCardDetailsNotifier>(context, listen: false)
                      .backText = value;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
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
                    Provider.of<FlashCardDetailsNotifier>(context,
                            listen: false)
                        .difficulty = switch (value) {
                      1 => Difficulty.easy,
                      2 => Difficulty.medium,
                      3 => Difficulty.hard,
                      _ => Difficulty.hard,
                    };
                  });
                },
                value: Provider.of<FlashCardDetailsNotifier>(context,
                            listen: false)
                        .difficulty
                        .index +
                    1,
                min: 1,
                max: 3,
                label: switch (Provider.of<FlashCardDetailsNotifier>(context,
                        listen: false)
                    .difficulty) {
                  Difficulty.easy => 'Easy',
                  Difficulty.medium => 'Medium',
                  Difficulty.hard => 'Hard'
                },
                divisions: 2,
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
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
                onChanged: (String value) {
                  Provider.of<FlashCardDetailsNotifier>(context, listen: false)
                      .tags = value;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
