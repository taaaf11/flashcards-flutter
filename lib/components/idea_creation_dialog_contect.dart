// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:flashcards/models/flashcard.dart';
import 'package:flashcards/notifiers/flashcard_details.dart';

class IdeaCreationForm extends StatefulWidget {
  final bool editFlashCard;
  final FlashCard? flashCardForEdit;

  const IdeaCreationForm({
    super.key,
    this.editFlashCard = false,
    this.flashCardForEdit,
  });

  @override
  State<IdeaCreationForm> createState() => _IdeaCreationFormState();
}

class _IdeaCreationFormState extends State<IdeaCreationForm> {
  late TextEditingController _frontTextEditingController;
  late TextEditingController _tagsTextEditingController;

  @override
  void initState() {
    if (widget.editFlashCard) {
      assert(widget.flashCardForEdit != null,
          'Flashcard is not provided for editing.');

      Provider.of<FlashCardDetailsNotifier>(context, listen: false).frontText =
          widget.flashCardForEdit!.frontText;
      Provider.of<FlashCardDetailsNotifier>(context, listen: false).tags =
          widget.flashCardForEdit!.tags.join(',');
    }

    _frontTextEditingController = TextEditingController(
        text: Provider.of<FlashCardDetailsNotifier>(context, listen: false)
            .frontText);
    _tagsTextEditingController = TextEditingController(
        text:
            Provider.of<FlashCardDetailsNotifier>(context, listen: false).tags);

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
