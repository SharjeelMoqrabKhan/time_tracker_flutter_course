class Job {
  Job({this.name, this.ratePerhour});
  final String name;
  final int ratePerhour;

  Map<String, dynamic> toMap() {
    return {'name': name, 'ratePerHour': ratePerhour};
  }
}
