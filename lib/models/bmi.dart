class History {
  double height;
  double weight;
  double bmi;
  String description;

  History(
      {required this.height,
      required this.weight,
      required this.bmi,
      required this.description});
}

class ResultBmi {
  String description;
  String suggestion;
  String category;
  String links;

  ResultBmi(
    {
      required this.description,
      required this.suggestion,
      required this.category,
      required this.links
    }
  );
}