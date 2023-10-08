import 'package:flame/components.dart';

bool checkCollision(player, block) {
  final hitbox = player.hitbox;
  final playerX = player.position.x + hitbox.offsetX;
  final playerY = player.position.y + hitbox.offsetY;
  final playerWidth = hitbox.width;
  final playerHeight = hitbox.height;

  final blockX = block.x;
  final blockY = block.y;
  final blockWidth = block.width;
  final blockHeight = block.height;

  final fixedX = player.scale.x < 0
      ? playerX - (hitbox.offsetX * 2) - playerWidth
      : playerX;
  final fixedY = block.isPlatform ? playerY + playerHeight : playerY;

  return (fixedY < blockY + blockHeight &&
      playerY + playerHeight > blockY &&
      fixedX < blockX + blockWidth &&
      fixedX + playerWidth > blockX);
}

bool checkItemWallCollision(item, List<Block> blocks) {
  for (final block in blocks) {
    if (checkCollision(item, block)) {
      return true; // Nếu có va chạm với ít nhất một khối tường, trả về true
    }
  }
  return false; // Không có va chạm với bất kỳ khối tường nào, trả về false
}

