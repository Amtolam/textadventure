class DecisionData {
  final String text;
  final String headline;
  final String option1;
  final String image;
  final String option2;

  DecisionData({
    required this.text,
    required this.headline,
    required this.option1,
    required this.option2,
    required this.image,
  });

  factory DecisionData.fromJson(Map<String, dynamic> json) {
    return DecisionData(
      text: json['text'],
      headline: json['headline'],
      option1: json['option1']["headline"],
      option2: json['option2']["headline"],
      image: json['image'],
    );
  }
}
