import 'package:flutter/material.dart';
import '../models/hero_model.dart';
import '../services/api_service.dart';
import '../services/database_service.dart';
import 'hero_detail_screen.dart';
import 'hero_compare_screen.dart';

class HeroListScreen extends StatefulWidget {
  const HeroListScreen({super.key});

  @override
  State<HeroListScreen> createState() => _HeroListScreenState();
}

class _HeroListScreenState extends State<HeroListScreen> {
  List<HeroModel> _heroes = [];
  List<HeroModel> _filteredHeroes = [];

  bool _isLoading = true;
  String? _errorMessage;

  String _searchQuery = '';
  String _selectedAttribute = 'All';
  String _sortOrder = 'A-Z';

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _applyFilters() {
    List<HeroModel> result = List.from(_heroes);

    // FILTER: attribute
    if (_selectedAttribute != 'All') {
      result = result
          .where((h) => h.primaryAttr == _selectedAttribute)
          .toList();
    }

    // FILTER: search
    if (_searchQuery.isNotEmpty) {
      result = result.where((h) {
        return h.localizedName
            .toLowerCase()
            .contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // SORT
    result.sort((a, b) {
      return _sortOrder == 'A-Z'
          ? a.localizedName.compareTo(b.localizedName)
          : b.localizedName.compareTo(a.localizedName);
    });

    setState(() {
      _filteredHeroes = result;
    });
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final apiHeroes = await ApiService.fetchHeroes();
      await DatabaseService.saveHeroes(apiHeroes);

      _heroes = apiHeroes;
      _filteredHeroes = apiHeroes;

      _applyFilters();
    } catch (e) {
      final localHeroes = DatabaseService.getHeroes();

      _heroes = localHeroes;
      _filteredHeroes = localHeroes;

      if (localHeroes.isEmpty) {
        _errorMessage = 'Failed to load data.';
      }

      _applyFilters();
    }

    setState(() => _isLoading = false);
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search hero...',
          prefixIcon: const Icon(Icons.search),

          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              _searchController.clear();
              _searchQuery = '';
              _applyFilters();
            },
          )
              : null,

          border: const OutlineInputBorder(),
        ),
        onChanged: (value) {
          _searchQuery = value;
          _applyFilters();
        },
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _selectedAttribute,
              decoration: const InputDecoration(
                labelText: 'Attribute',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'All', child: Text('All')),
                DropdownMenuItem(value: 'str', child: Text('Strength')),
                DropdownMenuItem(value: 'agi', child: Text('Agility')),
                DropdownMenuItem(value: 'int', child: Text('Intelligence')),
              ],
              onChanged: (value) {
                _selectedAttribute = value!;
                _applyFilters();
              },
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: DropdownButtonFormField<String>(
              value: _sortOrder,
              decoration: const InputDecoration(
                labelText: 'Sort',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'A-Z', child: Text('A-Z')),
                DropdownMenuItem(value: 'Z-A', child: Text('Z-A')),
              ],
              onChanged: (value) {
                _sortOrder = value!;
                _applyFilters();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _filteredHeroes.length,
        itemBuilder: (context, index) {
          final hero = _filteredHeroes[index];

          return Card(
            color: const Color(0xFF252529),
            child: ListTile(
              leading: Image.network(hero.fullImageUrl, width: 60),

              title: Text(
                hero.localizedName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              subtitle: Text(
                '${hero.attackType} / ${hero.primaryAttr.toUpperCase()}',
              ),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HeroDetailScreen(hero: hero),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 60, color: Colors.red),
          const SizedBox(height: 12),
          Text(_errorMessage ?? ''),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _loadData,
            child: const Text('Retry'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dota 2 Heroes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.compare_arrows),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HeroCompareScreen(heroes: _heroes),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? _buildError()
          : Column(
        children: [
          _buildSearch(),
          const SizedBox(height: 8),
          _buildFilters(),
          const SizedBox(height: 8),
          _buildList(),
        ],
      ),
    );
  }
}