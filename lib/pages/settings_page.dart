// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';

// 🌎 Project imports:
import 'package:flashcards/components/icon_text_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    AdaptiveThemeMode currentThemeMode = AdaptiveTheme.of(context).mode;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 137,
            child: IconTextButton(
              icon: Icon(
                currentThemeMode == AdaptiveThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
                color: Theme.of(context).colorScheme.primary,
              ),
              padding: const EdgeInsets.all(8),
              spacing: 10,
              onPress: () => currentThemeMode == AdaptiveThemeMode.light
                  ? AdaptiveTheme.of(context).setDark()
                  : AdaptiveTheme.of(context).setLight(),
              child: Text(
                currentThemeMode == AdaptiveThemeMode.light
                    ? 'Dark Mode'
                    : 'Light Mode',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
