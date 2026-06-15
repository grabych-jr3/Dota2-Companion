import 'package:flutter/material.dart';
import '../models/hero_model.dart';

class HeroDetailScreen extends StatelessWidget {
  final HeroModel hero;

  const HeroDetailScreen({
    super.key,
    required this.hero,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hero.localizedName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 220,
              color: const Color(0xFF252529),
              child: Image.network(
                hero.fullImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 60),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hero.localizedName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '${hero.attackType.toUpperCase()} • ${hero.primaryAttr.toUpperCase()}',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                  ),

                  const Divider(height: 32),

                  const Text(
                    'Base Stats',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatCard(
                        '❤️ HP',
                        '${hero.baseHealth}',
                      ),
                      _buildStatCard(
                        '🔷 Mana',
                        '${hero.baseMana}',
                      ),
                      _buildStatCard(
                        '⚡ Speed',
                        '${hero.moveSpeed}',
                      ),
                    ],
                  ),

                  const Divider(height: 32),

                  const Text(
                    'Hero Roles',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: hero.roles.map((role) {
                      return Chip(
                        label: Text(role.toString()),
                        backgroundColor: const Color(0xFF252529),
                      );
                    }).toList(),
                  ),

                  const Divider(height: 32),

                  const Text(
                    'Combat Stats',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  _buildInfoTile(
                    'Damage',
                    '${hero.baseAttackMin} - ${hero.baseAttackMax}',
                  ),

                  _buildInfoTile(
                    'Armor',
                    hero.baseArmor.toStringAsFixed(1),
                  ),

                  _buildInfoTile(
                    'Attack Range',
                    '${hero.attackRange}',
                  ),

                  _buildInfoTile(
                    'Projectile Speed',
                    '${hero.projectileSpeed}',
                  ),

                  const Divider(height: 32),

                  const Text(
                    'Hero Summary',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF252529),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${hero.localizedName} is a '
                          '${hero.attackType.toLowerCase()} hero whose primary attribute is '
                          '${hero.primaryAttr.toUpperCase()}. '
                          'This hero starts with ${hero.baseHealth} health, '
                          '${hero.baseMana} mana and '
                          '${hero.moveSpeed} movement speed. '
                          'Its base damage is '
                          '${hero.baseAttackMin}-${hero.baseAttackMax} and armor is '
                          '${hero.baseArmor.toStringAsFixed(1)}.',
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildStatCard(
      String label,
      String value,
      ) {
    return Container(
      width: 105,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF252529),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildInfoTile(
      String title,
      String value,
      ) {
    return Card(
      color: const Color(0xFF252529),
      child: ListTile(
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}