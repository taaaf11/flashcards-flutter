import 'package:flashcards/notifiers/flashcard_type_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flashcards/types.dart';

class FlashCardType extends StatefulWidget {
  const FlashCardType({super.key});

  @override
  State<FlashCardType> createState() => _FlashCardTypeState();
}

class _FlashCardTypeState extends State<FlashCardType> {
  @override
  Widget build(BuildContext context) {
    var flashCardTypeState = Provider.of<FlashCardTypeNotifier>(context);

    return SegmentedButton<CardType>(
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
      selected: <CardType>{flashCardTypeState.selection},
      onSelectionChanged: (Set<CardType> newSelection) {
        setState(
          () {
            flashCardTypeState.changeSelection(newSelection.first);
          },
        );
      },
    );
  }
}
