class Level {
  final int id;
  final String levelName;

  Level(this.id, this.levelName);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'levelName': levelName,
    };
  }
}