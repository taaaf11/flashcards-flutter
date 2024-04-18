// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';

// 🌎 Project imports:
import 'package:flashcards/components/actions_dialog.dart';
import 'package:flashcards/components/flashcard_info_dialog.dart';
import 'package:flashcards/models/flashcard.dart';
import 'package:flashcards/utils.dart';

class FlashCardWidget extends StatelessWidget {
  final FlashCard flashCard;

  const FlashCardWidget({super.key, required this.flashCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getCardColor(context, flashCard),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          hoverDuration: const Duration(milliseconds: 20),
          splashColor: Theme.of(context).splashColor.withOpacity(0.1),
          onTap: () {
            showGeneralDialog(
              context: context,
              barrierLabel: 'FlashCardInfo Dialog',
              barrierDismissible: true,
              pageBuilder: (_, animation, __) =>
                  FlashCardInfoDialog(flashCard: flashCard),
              transitionBuilder:
                  (context, animation, secondaryAnimation, child) {
                return AnimatedOpacity(
                  opacity: animation.value,
                  duration: const Duration(milliseconds: 8),
                  child: child,
                );
              },
            );
          },
          onLongPress: () {
            showGeneralDialog(
              context: context,
              barrierLabel: 'Actions Dialog',
              barrierDismissible: true,
              pageBuilder: (_, animation, __) =>
                  ActionsDialog(flashCard: flashCard),
              transitionBuilder:
                  (context, animation, secondaryAnimation, child) {
                return AnimatedOpacity(
                  opacity: animation.value,
                  duration: const Duration(milliseconds: 8),
                  child: child,
                );
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
                              // color: getTextColor(context, flashCard),
                              color: AdaptiveTheme.of(context).mode ==
                                      AdaptiveThemeMode.dark
                                  ? Colors.white
                                  : Colors.black,
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
                                color: AdaptiveTheme.of(context).mode ==
                                        AdaptiveThemeMode.light
                                    ? DefaultTextStyle.of(context)
                                        .style
                                        .color
                                        ?.withOpacity(0.7)
                                    : Colors.white,
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
