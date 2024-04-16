import 'package:flashcards/components/actions_dialog.dart';
import 'package:flashcards/components/back_text_dialog.dart';
import 'package:flashcards/constants.dart';
import 'package:flashcards/types.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/models/flashcard.dart';

class FlashCardWidget extends StatelessWidget {
  final FlashCard flashCard;

  const FlashCardWidget({super.key, required this.flashCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: switch (flashCard.type) {
          CardType.idea => const Color(0xffffef00).withAlpha(180),
          CardType.qa => switch (flashCard.difficulty) {
              1 => kPrimaryColor.withAlpha(125),
              // 2 => Colors.orange.withAlpha(125),
              2 => const Color(0xffffe5b4),
              3 => Colors.red.withAlpha(125),
              null => const Color(0xffffef00).withAlpha(180),
              // null => Colors.yellow.withAlpha(125),
              _ => Colors.transparent,
            },
        },
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          hoverDuration: const Duration(milliseconds: 20),
          splashColor: Theme.of(context).splashColor.withOpacity(0.1),
          onTap: () {
            if (flashCard.backText == null) return;
            showDialog(
              context: context,
              builder: (context) {
                return FlashCardInfoDialog(flashCard: flashCard);
              },
            );
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) {
                return ActionsDialog(flashCard: flashCard);
              },
            );
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        flashCard.frontText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontFamily: 'Comfortaa',
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      Visibility(
                        visible: flashCard.tags.isNotEmpty,
                        child: Column(
                          children: [
                            const SizedBox(height: 5),
                            Text(
                              'tags: ${flashCard.tags.join(', ')}',
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.w500,
                                color: DefaultTextStyle.of(context)
                                    .style
                                    .color
                                    ?.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Icon(
                  flashCard.difficulty != null
                      ? Icons.question_mark_rounded
                      : Icons.lightbulb_outline_rounded,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
