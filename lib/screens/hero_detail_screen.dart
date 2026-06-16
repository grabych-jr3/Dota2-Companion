import 'package:flutter/material.dart';

import '../models/hero_model.dart';
import '../models/matchup_model.dart';
import '../services/api_service.dart';
import '../services/database_service.dart';

class HeroDetailScreen extends StatefulWidget {
  final HeroModel hero;

  const HeroDetailScreen({
    super.key,
    required this.hero,
  });

  @override
  State<HeroDetailScreen> createState() =>
      _HeroDetailScreenState();
}

class _HeroDetailScreenState
    extends State<HeroDetailScreen> {
  List<MatchupModel> _matchups = [];
  bool _isLoadingMatchups = true;

  @override
  void initState() {
    super.initState();
    _loadMatchups();
  }

  Future<void> _loadMatchups() async {
    try {
      final matchups =
      await ApiService.fetchHeroMatchups(
        widget.hero.id,
      );

      matchups.sort(
            (a, b) => b.winRate.compareTo(a.winRate),
      );

      setState(() {
        _matchups = matchups.take(5).toList();
        _isLoadingMatchups = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingMatchups = false;
      });
    }
  }

  String _heroNameFromId(int heroId) {
    final hero =
    DatabaseService.getHeroById(heroId);

    return hero?.localizedName ??
        'Hero #$heroId';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hero.localizedName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 220,
              color: const Color(0xFF252529),
              child: Image.network(
                widget.hero.fullImageUrl,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 60,
                  );
                },
              ),
            ),

            Padding(
              padding:
              const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.hero.localizedName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '${widget.hero.attackType.toUpperCase()} • ${widget.hero.primaryAttr.toUpperCase()}',
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
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [
                      _buildStatCard(
                        '❤️ HP',
                        '${widget.hero.baseHealth}',
                      ),
                      _buildStatCard(
                        '🔷 Mana',
                        '${widget.hero.baseMana}',
                      ),
                      _buildStatCard(
                        '⚡ Speed',
                        '${widget.hero.moveSpeed}',
                      ),
                    ],
                  ),

                  const Divider(height: 32),

                  const Text(
                    'Hero Roles',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                    widget.hero.roles
                        .map((role) {
                      return Chip(
                        label: Text(
                          role.toString(),
                        ),
                        backgroundColor:
                        const Color(
                          0xFF252529,
                        ),
                      );
                    }).toList(),
                  ),

                  const Divider(height: 32),

                  const Text(
                    'Combat Stats',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  _buildInfoTile(
                    'Damage',
                    '${widget.hero.baseAttackMin} - ${widget.hero.baseAttackMax}',
                  ),

                  _buildInfoTile(
                    'Armor',
                    widget.hero.baseArmor
                        .toStringAsFixed(1),
                  ),

                  _buildInfoTile(
                    'Attack Range',
                    '${widget.hero.attackRange}',
                  ),

                  _buildInfoTile(
                    'Projectile Speed',
                    '${widget.hero.projectileSpeed}',
                  ),

                  const Divider(height: 32),

                  const Text(
                    'Best Matchups',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (_isLoadingMatchups)
                    const Center(
                      child:
                      CircularProgressIndicator(),
                    )
                  else
                    Column(
                      children:
                      _matchups.map(
                            (matchup) {
                          return Card(
                            color:
                            const Color(
                              0xFF252529,
                            ),
                            child: ListTile(
                              leading: Builder(
                                builder: (context) {
                                  final hero =
                                  DatabaseService.getHeroById(matchup.heroId);

                                  if (hero == null) {
                                    return const CircleAvatar(
                                      child: Icon(Icons.person),
                                    );
                                  }

                                  return CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      hero.fullImageUrl,
                                    ),
                                  );
                                },
                              ),
                              title: Text(
                                _heroNameFromId(
                                  matchup
                                      .heroId,
                                ),
                              ),
                              subtitle: Text(
                                'Games: ${matchup.gamesPlayed}',
                              ),
                              trailing:
                              Text(
                                '${matchup.winRate.toStringAsFixed(1)}%',
                                style:
                                const TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .bold,
                                  color: Colors
                                      .green,
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),

                  const Divider(height: 32),

                  const Text(
                    'Hero Summary',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    padding:
                    const EdgeInsets
                        .all(16),
                    decoration:
                    BoxDecoration(
                      color: const Color(
                        0xFF252529,
                      ),
                      borderRadius:
                      BorderRadius
                          .circular(
                        12,
                      ),
                    ),
                    child: Text(
                      '${widget.hero.localizedName} is a '
                          '${widget.hero.attackType.toLowerCase()} hero whose primary attribute is '
                          '${widget.hero.primaryAttr.toUpperCase()}. '
                          'This hero starts with ${widget.hero.baseHealth} health, '
                          '${widget.hero.baseMana} mana and '
                          '${widget.hero.moveSpeed} movement speed. '
                          'Its base damage is '
                          '${widget.hero.baseAttackMin}-${widget.hero.baseAttackMax} and armor is '
                          '${widget.hero.baseArmor.toStringAsFixed(1)}.',
                      style:
                      const TextStyle(
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
      padding:
      const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:
        const Color(0xFF252529),
        borderRadius:
        BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style:
            const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style:
            const TextStyle(
              fontSize: 16,
              fontWeight:
              FontWeight.bold,
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
      color:
      const Color(0xFF252529),
      child: ListTile(
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(
            fontWeight:
            FontWeight.bold,
          ),
        ),
      ),
    );
  }
}