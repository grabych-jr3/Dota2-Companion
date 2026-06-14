import 'package:hive/hive.dart';
import '../models/hero_model.dart';

class DatabaseService {
  static const String _boxName = 'heroesBox';

  static Future<void> saveHeroes(List<HeroModel> heroes) async {
    var box = Hive.box<HeroModel>(_boxName);
    await box.clear();
    for (var hero in heroes) {
      await box.put(hero.id, hero);
    }
  }

  static List<HeroModel> getHeroes() {
    var box = Hive.box<HeroModel>(_boxName);
    return box.values.toList();
  }
}