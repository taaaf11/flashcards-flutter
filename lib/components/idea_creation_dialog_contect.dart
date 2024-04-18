import 'package:flashcards/notifiers/flashcard_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IdeaCreationForm extends StatefulWidget {
  const IdeaCreationForm({super.key});

  @override
  State<IdeaCreationForm> createState() => _IdeaCreationFormState();
}

class _IdeaCreationFormState extends State<IdeaCreationForm> {
  late TextEditingController _frontTextEditingController;
  late TextEditingController _tagsTextEditingController;

  @override
  void initState() {
    _frontTextEditingController = TextEditingController();
    _tagsTextEditingController = TextEditingController();

    _frontTextEditingController.text =
        Provider.of<FlashCardDetailsNotifier>(context, listen: false)
                .frontText ??
            '';
    _tagsTextEditingController.text =
        Provider.of<FlashCardDetailsNotifier>(context, listen: false).tags ??
            '';

    super.initState();
  }

  @override
  void dispose() {
    _frontTextEditingController.dispose();
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
                'Idea:',
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
                    Provider.of<FlashCardDetailsNotifier>(context,
                            listen: false)
                        .tags = value;
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
