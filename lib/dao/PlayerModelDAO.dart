import 'package:journey_of_salvation/components/database/level_db.dart';
import 'package:journey_of_salvation/components/model/level.dart';

void main() async {
  //create level
  Level level = Level(1, 'Level-01');

  //insert level
  LevelDB().insert(level.toMap());

  //fetch all
  List<Map<String, dynamic>> levels = await LevelDB().fetchAll();
  print(levels);
}