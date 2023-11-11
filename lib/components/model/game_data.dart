class GameData {
  final int id;
  final String character;
  final String coin;

  GameData(this.id, this.character, this.coin);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'character': character,
      'coin': coin,
    };
  }
}