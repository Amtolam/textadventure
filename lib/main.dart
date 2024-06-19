import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 160, 107)),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 122, 0, 81)),
      ),
      home: const SelectionPage(),
    );
  }
}

class DecisionData {
  final int id;
  final String text;
  final String headline;
  final String option1;
  final String image;
  final String option2;

  DecisionData({
    required this.id,
    required this.text,
    required this.headline,
    required this.option1,
    required this.option2,
    required this.image,
  });

  factory DecisionData.fromJson(Map<String, dynamic> json) {
    return DecisionData(
      id: json['id'],
      text: json['text'],
      headline: json['headline'],
      option1: json['option1']["headline"],
      option2: json['option2']["headline"],
      image: json['image'],
    );
  }
}

class ConsequenceData {
  final String text;
  final String headline;
  final String image;
  final int points;

  ConsequenceData({
    required this.text,
    required this.headline,
    required this.points,
    required this.image,
  });

  factory ConsequenceData.fromJson(Map<String, dynamic> json) {
    return ConsequenceData(
      text: json['text'],
      headline: json['headline'],
      points: json['points'],
      image: json['image'],
    );
  }
}

class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Select your adventure', style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdventurePage(source: "data/data.json"))),
                  child: const Text('Modern life'),
                  style: ElevatedButton.styleFrom(fixedSize: const Size.fromHeight(70), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdventurePage(source: "data/data_old.json"))),
                  child: const Text('Pre-World Wide Web life'),
                  style: ElevatedButton.styleFrom(fixedSize: const Size.fromHeight(70), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

class AdventurePage extends StatefulWidget {
  const AdventurePage({super.key, required this.source});
  final String source;

  @override
  State<AdventurePage> createState() => _AdventurePageState();
}

class _AdventurePageState extends State<AdventurePage> {
  int id = 0;
  int points = 0;
  DecisionData? decisionData;
  ConsequenceData? consequenceData;

  late dynamic _data;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    _data = jsonDecode(await rootBundle.loadString(widget.source));
    setState(() {decisionData = DecisionData.fromJson(_data[id]);});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: decisionData == null && consequenceData == null
          ? const Center(child: CircularProgressIndicator())
          : Align(
            key: ValueKey("$id ${decisionData != null ? "decision" : "consequence"}"),
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: (MediaQuery.sizeOf(context).height.floor() * .35).floor().toDouble(),
                    width: MediaQuery.sizeOf(context).width,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                      },
                      blendMode: BlendMode.dstIn,
                      child: FadeInImage(
                        placeholder: const AssetImage('data/images/placeholder.png'),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        image: Image.network((decisionData?.image ?? consequenceData?.image ?? "https://via.placeholder.com/1920")).image,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 920),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(decisionData?.headline ?? consequenceData?.headline ?? "<No headline>",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const SizedBox(height: 30),
                          Text(
                            //"""Consequat eiusmod mollit deserunt sint aliqua culpa qui occaecat ut incididunt minim. In reprehenderit laborum cupidatat nostrud sit consequat sunt consequat. Nostrud commodo esse non magna.\n\nUt ea non non enim ea Lorem ullamco ad quis et qui nisi. Tempor ut cillum nulla reprehenderit eiusmod proident commodo eiusmod eu pariatur mollit incididunt mollit voluptate. Ut ea proident id ullamco ut elit minim elit culpa do. Ullamco nulla Lorem ullamco culpa nisi laborum proident sit irure ipsum quis. Ut deserunt eiusmod non commodo voluptate magna irure velit sunt labore. Deserunt dolor amet proident do cillum quis aute.\n\nCommodo commodo irure ex id sunt veniam cillum laborum reprehenderit reprehenderit nostrud in. Fugiat dolor pariatur veniam dolor velit laborum eu sit eu. Voluptate labore mollit mollit et id. Voluptate anim reprehenderit dolore officia dolor et officia esse consequat cillum Lorem deserunt.""",
                            //"Ullamco in consequat mollit adipisicing mollit duis cupidatat deserunt et exercitation aliqua. Voluptate non occaecat sint officia aute consectetur duis reprehenderit nulla. Ea duis officia ut amet culpa eiusmod voluptate dolore anim ut id. Duis aliqua voluptate proident anim deserunt. Excepteur eu non sit ut pariatur pariatur est aliquip non pariatur. Sunt fugiat sit anim voluptate velit et culpa in.",
                            decisionData?.text ?? consequenceData?.text ?? "<No text>",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 30),
                          if (decisionData != null) LayoutBuilder(
                            builder: (context, constraints) {
                              final option1 = ElevatedButton(
                                style: ElevatedButton.styleFrom(visualDensity: VisualDensity.comfortable),
                                onPressed: () => {
                                  setState(() {
                                    decisionData = null;
                                    consequenceData = ConsequenceData.fromJson(_data[id]["option1"]);
                                    points += consequenceData!.points;
                                  }),
                                },
                                child: Text(decisionData?.option1 ?? "<No option>"),
                              );
                              final option2 = ElevatedButton(
                                style: ElevatedButton.styleFrom(visualDensity: VisualDensity.comfortable),
                                onPressed: () => {
                                  setState(() {
                                    decisionData = null;
                                    consequenceData = ConsequenceData.fromJson(_data[id]["option2"]);
                                    points += consequenceData!.points;
                                  }),
                                },
                                child: Text(decisionData?.option2 ?? "<No option>"),
                              );

                              if (constraints.maxWidth > 600) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: option1
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: option2
                                    ),
                                  ],
                                );
                              } else {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    option1,
                                    const SizedBox(height: 10),
                                    option2,
                                    const SizedBox(height: 30),
                                  ],
                                );
                              }
                            },
                          ),
                          if (consequenceData != null) ElevatedButton(
                            style: ElevatedButton.styleFrom(visualDensity: VisualDensity.comfortable),
                            onPressed: () => {
                              setState(() {
                                if (_data.length == id + 1) {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Scaffold(
                                    body: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("Day over!", style: Theme.of(context).textTheme.headlineLarge),
                                            const SizedBox(height: 20),
                                            Text('Your decisions resulted in $points points.', style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
                                            const SizedBox(height: 10),
                                            Text("The more points you have, the more you adapted to the effects that the world wide web has on your daily life.", textAlign: TextAlign.center,),
                                            const SizedBox(height: 20),
                                            ElevatedButton(
                                              onPressed: () => {
                                                setState(() {
                                                  id = 0;
                                                  points = 0;
                                                  decisionData = DecisionData.fromJson(_data[id]);
                                                  consequenceData = null;
                                                }),
                                                Navigator.of(context).pop(),
                                              },
                                              child: const Text('Restart'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )));
                                  return;
                                }
                                id += 1;
                                consequenceData = null;
                                decisionData = DecisionData.fromJson(_data[id]);
                              }),
                            },
                            child: const Text('Continue'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
      ),
    );
  }
}
