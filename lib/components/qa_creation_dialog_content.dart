import 'package:flashcards/notifiers/flashcard_details.dart';
import 'package:flashcards/types.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QACreationForm extends StatefulWidget {
  const QACreationForm({super.key});

  @override
  State<QACreationForm> createState() => _QACreationFormState();
}

class _QACreationFormState extends State<QACreationForm> {
  late TextEditingController _frontTextEditingController;
  late TextEditingController _backTextEditingController;
  late TextEditingController _tagsTextEditingController;

  @override
  void initState() {
    _frontTextEditingController = TextEditingController();
    _backTextEditingController = TextEditingController();
    _tagsTextEditingController = TextEditingController();

    _frontTextEditingController.text =
        Provider.of<FlashCardDetailsNotifier>(context, listen: false)
                .frontText ??
            '';
    _backTextEditingController.text =
        Provider.of<FlashCardDetailsNotifier>(context, listen: false)
                .backText ??
            '';

    _tagsTextEditingController.text =
        Provider.of<FlashCardDetailsNotifier>(context, listen: false).tags ??
            '';

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
                value: (Provider.of<FlashCardDetailsNotifier>(context,
                                listen: false)
                            .difficulty
                            ?.index ??
                        0) +
                    1,
                min: 1,
                max: 3,
                label: switch (Provider.of<FlashCardDetailsNotifier>(context,
                        listen: false)
                    .difficulty) {
                  Difficulty.easy => 'Easy',
                  Difficulty.medium => 'Medium',
                  Difficulty.hard => 'Hard',
                  null => 'Easy'
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
