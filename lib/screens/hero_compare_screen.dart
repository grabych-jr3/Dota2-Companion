import 'package:flutter/material.dart';
import '../models/hero_model.dart';

class HeroCompareScreen extends StatefulWidget {
  final List<HeroModel> heroes;

  const HeroCompareScreen({
    super.key,
    required this.heroes,
  });

  @override
  State<HeroCompareScreen> createState() => _HeroCompareScreenState();
}

class _HeroCompareScreenState extends State<HeroCompareScreen> {
  HeroModel? hero1;
  HeroModel? hero2;

  Widget _buildHeroSelector({
    required String label,
    required HeroModel? selectedHero,
    required ValueChanged<HeroModel?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        DropdownButtonFormField<HeroModel>(
          value: selectedHero,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          isExpanded: true,
          items: widget.heroes.map((hero) {
            return DropdownMenuItem(
              value: hero,
              child: Text(hero.localizedName),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget buildRow(String stat, String v1, String v2) {
    return Card(
      color: const Color(0xFF252529),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                stat,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child: Text(v1, textAlign: TextAlign.center)),
            Expanded(child: Text(v2, textAlign: TextAlign.center)),
          ],
        ),
      ),
    );
  }

  Widget _heroHeader(HeroModel hero) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(hero.fullImageUrl),
        ),
        const SizedBox(height: 6),
        Text(
          hero.localizedName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Comparison'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _buildHeroSelector(
              label: "Hero 1",
              selectedHero: hero1,
              onChanged: (v) => setState(() => hero1 = v),
            ),

            const SizedBox(height: 12),

            _buildHeroSelector(
              label: "Hero 2",
              selectedHero: hero2,
              onChanged: (v) => setState(() => hero2 = v),
            ),

            const SizedBox(height: 16),

            if (hero1 != null && hero2 != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _heroHeader(hero1!),
                  const Icon(Icons.compare_arrows, size: 30),
                  _heroHeader(hero2!),
                ],
              ),

              const SizedBox(height: 16),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildRow('Health',
                          '${hero1!.baseHealth}', '${hero2!.baseHealth}'),
                      buildRow('Mana',
                          '${hero1!.baseMana}', '${hero2!.baseMana}'),
                      buildRow('Speed',
                          '${hero1!.moveSpeed}', '${hero2!.moveSpeed}'),
                      buildRow(
                        'Damage',
                        '${hero1!.baseAttackMin}-${hero1!.baseAttackMax}',
                        '${hero2!.baseAttackMin}-${hero2!.baseAttackMax}',
                      ),
                      buildRow('Armor',
                          hero1!.baseArmor.toStringAsFixed(1),
                          hero2!.baseArmor.toStringAsFixed(1)),
                      buildRow('Attack Range',
                          '${hero1!.attackRange}', '${hero2!.attackRange}'),
                      buildRow('Projectile Speed',
                          '${hero1!.projectileSpeed}',
                          '${hero2!.projectileSpeed}'),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}