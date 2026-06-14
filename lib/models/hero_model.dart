import 'package:hive/hive.dart';

part 'hero_model.g.dart';

@HiveType(typeId: 0)
class HeroModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String localizedName;

  @HiveField(3)
  final String primaryAttr;

  @HiveField(4)
  final String attackType;

  @HiveField(5)
  final String img;

  @HiveField(6)
  final int baseHealth;

  @HiveField(7)
  final int baseMana;

  @HiveField(8)
  final int moveSpeed;

  HeroModel({
    required this.id,
    required this.name,
    required this.localizedName,
    required this.primaryAttr,
    required this.attackType,
    required this.img,
    required this.baseHealth,
    required this.baseMana,
    required this.moveSpeed,
  });

  factory HeroModel.fromJson(Map<String, dynamic> json) {
    return HeroModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      localizedName: json['localized_name'] ?? 'Unknown',
      primaryAttr: json['primary_attr'] ?? '',
      attackType: json['attack_type'] ?? '',
      img: json['img'] ?? '',
      baseHealth: json['base_health'] ?? 200,
      baseMana: json['base_mana'] ?? 75,
      moveSpeed: json['move_speed'] ?? 300,
    );
  }

  String get fullImageUrl =>
      'https://cdn.cloudflare.steamstatic.com$img';
}