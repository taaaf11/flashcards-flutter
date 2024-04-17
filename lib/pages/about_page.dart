import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Written by:', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 15),
          const CircleAvatar(
            foregroundImage: NetworkImage(
              'https://avatars.githubusercontent.com/u/109919009?s=256&v=4',
            ),
            radius: 40,
          ),
          const SizedBox(height: 18),
          Text(
            'Muhammad Altaaf',
            style: Theme.of(context).textTheme.titleLarge,
          )
        ],
      ),
    );
  }
}
