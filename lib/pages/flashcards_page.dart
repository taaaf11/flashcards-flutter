// 🐦 Flutter imports:
import 'package:flashcards/notifiers/flashcards_animatedlist_key.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:flashcards/components/flashcard_widget.dart';
import 'package:flashcards/notifiers/flashcards_notifier.dart';

class FlashCardsPage extends StatefulWidget {
  const FlashCardsPage({super.key});

  @override
  State<FlashCardsPage> createState() => _FlashCardsPageState();
}

class _FlashCardsPageState extends State<FlashCardsPage> {
  @override
  Widget build(BuildContext context) {
    var flashCardsState = Provider.of<FlashCardsListProvider>(context);

    return Column(
      children: [
        Expanded(
          child: AnimatedList(
            key: FlashCardsAnimatedListKeyProvider.key,
            initialItemCount: flashCardsState.flashCards.length,
            itemBuilder: (context, index, animation) {
              return SizeTransition(
                sizeFactor: animation,
                child: FlashCardWidget(
                  flashCard: flashCardsState.flashCards[index],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
