import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:textadventure/logic/consequence_data.dart';
import 'package:textadventure/logic/decision_data.dart';

import 'result_page.dart';

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
                          end: Alignment(0, 1.01),
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                      },
                      blendMode: BlendMode.dstIn,
                      child: FadeInImage(
                        placeholder: const AssetImage('data/images/placeholder.png'),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
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
                            decisionData?.text ?? consequenceData?.text ?? "<No text>",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 15),
                          if (consequenceData?.infoHeadline?.isNotEmpty ?? false) Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Card.filled(
                              color: Theme.of(context).colorScheme.secondary,
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.info, color: Theme.of(context).colorScheme.onSecondary),
                                        const SizedBox(width: 15),
                                        Text(consequenceData?.infoHeadline ?? "<No info>", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSecondary)),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(consequenceData?.infoText ?? "<No info>", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSecondary)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          if (decisionData != null) LayoutBuilder(
                            builder: (context, constraints) {
                              final option1 = ElevatedButton(
                                style: ElevatedButton.styleFrom(visualDensity: VisualDensity.comfortable, fixedSize: const Size.fromHeight(70)),
                                onPressed: () => {
                                  setState(() {
                                    decisionData = null;
                                    consequenceData = ConsequenceData.fromJson(_data[id]["option1"]);
                                    points += consequenceData!.points;
                                  }),
                                },
                                child: Text(decisionData?.option1 ?? "<No option>", textAlign: TextAlign.center),
                              );
                              final option2 = ElevatedButton(
                                style: ElevatedButton.styleFrom(visualDensity: VisualDensity.comfortable, fixedSize: const Size.fromHeight(70)),
                                onPressed: () => {
                                  setState(() {
                                    decisionData = null;
                                    consequenceData = ConsequenceData.fromJson(_data[id]["option2"]);
                                    points += consequenceData!.points;
                                  }),
                                },
                                child: Text(decisionData?.option2 ?? "<No option>", textAlign: TextAlign.center),
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
                                  ],
                                );
                              }
                            },
                          ),
                          if (consequenceData != null) ElevatedButton(
                            style: ElevatedButton.styleFrom(visualDensity: VisualDensity.comfortable, fixedSize: const Size.fromHeight(70)),
                            onPressed: () => {
                              setState(() {
                                if (_data.length == id + 1) {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResultPage(points: points)));
                                  return;
                                }
                                id += 1;
                                consequenceData = null;
                                decisionData = DecisionData.fromJson(_data[id]);
                              }),
                            },
                            child: const Text('Weiter'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
