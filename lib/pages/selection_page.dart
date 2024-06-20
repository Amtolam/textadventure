import 'package:flutter/material.dart';
import 'adventure_page.dart';

class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [const Text("v1.0.1")],
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Wähle dein Szenario', style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdventurePage(source: "data/data.json"))),
                  style: ElevatedButton.styleFrom(fixedSize: const Size.fromHeight(70), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  child: const Text('Influencer 2024'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdventurePage(source: "data/data_old.json"))),
                  style: ElevatedButton.styleFrom(fixedSize: const Size.fromHeight(70), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  child: const Text('Popstar 1980'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
