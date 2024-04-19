// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class FlashCardsAnimatedListKeyProvider {
  static late final GlobalKey<AnimatedListState>? _key;

  static void initialize() {
    _key = GlobalKey();
  }

  static GlobalKey<AnimatedListState>? get key => _key;
  static AnimatedListState? get listeState => _key?.currentState;
}
