import 'package:flutter/material.dart';
import 'package:prescripto/data/database.dart';
import 'InventoryBackEnd.dart';

/// Displays only the logged-in pharmacist’s inventory.
class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final _backend = InventoryBackend(AppDatabase());
  List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> _filtered = [];
  bool _isLoading = true;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadInventory();
  }

  Future<void> _loadInventory() async {
    try {
      final items = await _backend.getInventoryItems();
      setState(() {
        _items = items;
        _filtered = items;
      });
    } catch (e) {
      debugPrint('Error loading inventory: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _filter(String q) {
    final query = q.toLowerCase();
    setState(() {
      _filtered = query.isEmpty
          ? _items
          : _items
          .where((i) => (i['medicationName'] as String)
          .toLowerCase()
          .contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: _filter,
            decoration: InputDecoration(
              hintText: 'Search medications…',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _filtered.isEmpty
                ? const Center(child: Text('No items found'))
                : ListView.builder(
              itemCount: _filtered.length,
              itemBuilder: (ctx, i) {
                final item = _filtered[i];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(item['medicationName']),
                    subtitle: Text('Qty: ${item['quantity']}'),
                    trailing: Text(
                      '\$${(item['price'] as double).toStringAsFixed(2)}',
                    ),
                    onTap: () {
                      // TODO: edit/view item details
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
