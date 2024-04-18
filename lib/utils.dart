// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:provider/provider.dart';
import 'package:flashcards/notifiers/flashcard_details.dart';

// 🌎 Project imports:
import 'constants.dart';
import 'types.dart';

List<String> getTagsFromTagsString(String tagsString,
    {String separater = ','}) {
  List<String> tagsList = tagsString.split(separater);
  tagsList = tagsList.map((e) => e.trim()).toList();
  if (tagsList.length == 1 && tagsList.first == '') return [];
  return tagsList;
}

Color getCardColor(context, flashCard) {
  switch (flashCard.type) {
    case CardType.idea:
      // return const Color(0xffffef00);
      return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
          ? const Color(0xffffef00).withAlpha(180)
          : const Color(0xffe1ad01);
    case CardType.qa:
      switch (flashCard.difficulty) {
        case Difficulty.easy:
          return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
              ? kPrimaryColor.withAlpha(125)
              : const Color(0xff01796f);
        // 2 => Colors.orange.withAlpha(125),
        case Difficulty.medium:
          return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
              ? const Color(0xffffe5b4)
              : const Color(0xfff7d560);
        case Difficulty.hard:
          return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
              ? Colors.red.withAlpha(125)
              : const Color(0xffcd5c5c);
      }
    default:
      return const Color(0xffffef00).withAlpha(180);
  }
  throw Exception("Unknown type/idea ");
}

void clearFlashCardDetails(context) {
  Provider.of<FlashCardDetailsNotifier>(context, listen: false).frontText = '';
  Provider.of<FlashCardDetailsNotifier>(context, listen: false).backText = '';
  Provider.of<FlashCardDetailsNotifier>(context, listen: false).tags = '';
  Provider.of<FlashCardDetailsNotifier>(context, listen: false).difficulty =
      null;
}
