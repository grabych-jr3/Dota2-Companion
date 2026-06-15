import 'package:flutter/material.dart';
import '../models/hero_model.dart';
import '../services/api_service.dart';
import '../services/database_service.dart';
import 'hero_detail_screen.dart';

class HeroListScreen extends StatefulWidget {
  const HeroListScreen({super.key});

  @override
  State<HeroListScreen> createState() => _HeroListScreenState();
}

class _HeroListScreenState extends State<HeroListScreen> {
  List<HeroModel> _heroes = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final apiHeroes = await ApiService.fetchHeroes();

      await DatabaseService.saveHeroes(apiHeroes);

      if (mounted) {
        setState(() {
          _heroes = apiHeroes;
          _isLoading = false;
        });
      }
    } catch (e) {
      final localHeroes = DatabaseService.getHeroes();

      if (mounted) {
        setState(() {
          _heroes = localHeroes;
          _isLoading = false;

          if (localHeroes.isEmpty) {
            _errorMessage =
            'Failed to load data. Please check your internet connection.';
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Network unavailable. Offline data loaded.'),
                backgroundColor: Colors.orange,
              ),
            );
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dota 2 Heroes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFE53935),
        ),
      )
          : _errorMessage != null
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 60,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE53935),
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      )
          : ListView.builder(
        itemCount: _heroes.length,
        itemBuilder: (context, index) {
          final hero = _heroes[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            color: const Color(0xFF252529),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  hero.fullImageUrl,
                  width: 60,
                  height: 35,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 60,
                      height: 35,
                      color: const Color(0xFF252529),
                      child: const Center(
                        child: SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFE53935)),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    print(error);

                    return Container(
                      width: 60,
                      height: 35,
                      color: Colors.grey[800],
                      child: const Icon(
                        Icons.broken_image,
                        size: 20,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              title: Text(
                hero.localizedName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${hero.attackType} / ${hero.primaryAttr.toUpperCase()}',
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HeroDetailScreen(hero: hero),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}