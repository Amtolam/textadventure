class ConsequenceData {
  final String text;
  final String headline;
  final String? infoHeadline;
  final String? infoText;
  final String image;
  final int points;

  ConsequenceData({
    required this.text,
    required this.headline,
    required this.points,
    required this.image,
    this.infoHeadline,
    this.infoText
  });

  factory ConsequenceData.fromJson(Map<String, dynamic> json) {
    return ConsequenceData(
      text: json['text'],
      headline: json['headline'],
      points: json['points'],
      image: json['image'],
      infoHeadline: json['info']?["headline"],
      infoText: json['info']?["text"]
    );
  }
}
