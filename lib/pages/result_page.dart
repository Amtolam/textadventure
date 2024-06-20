import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({
    super.key,
    required this.points,
  });

  final int points;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Tag vorbei!", style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 20),
              Text('Deine Entscheidungen haben dir $points Punkte eingebracht', style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text("Je mehr Punkte du hast, desto besser hast du dich an die Einflüsse angepasst, die globale Vernetzung auf deinen Alltag hat.", textAlign: TextAlign.center,),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => {
                  // setState(() {
                  //   id = 0;
                  //   points = 0;
                  //   decisionData = DecisionData.fromJson(_data[id]);
                  //   consequenceData = null;
                  // }),
                  Navigator.of(context).popUntil((_) => _.isFirst),
                },
                child: const Text('Wiederholen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
