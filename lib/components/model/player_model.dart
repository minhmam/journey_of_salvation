class PlayerModel {
  final int id;
  final String name;
  final int runSpeed;
  final int heath;
  final int jumpHeight;

  PlayerModel(this.id, this.name, this.runSpeed, this.heath, this.jumpHeight);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'runSpeed': runSpeed,
      'heath': heath,
      'jumpHeight': jumpHeight,
    };
  }
}