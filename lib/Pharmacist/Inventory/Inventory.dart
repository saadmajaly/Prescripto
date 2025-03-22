import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const InventoryScreen(),
    );
  }
}

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 200,
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Prescripto',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                const SizedBox(height: 20),
                _buildSidebarItem('Home'),
                _buildSidebarItem('Inventory', isActive: true),
                _buildSidebarItem('Reports'),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Manage inventory',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Add, remove and edit your inventory',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),

                  // Search Bar
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for a product',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Current inventory',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 16),

                  // Inventory Table
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Serial number')),
                          DataColumn(label: Text('Price')),
                          DataColumn(label: Text('QTY')),
                          DataColumn(label: Text('Reorder Threshold')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: [
                          _buildDataRow('Ibuprofen 200mg', '123-456-789', '\$10.00', '50', '10'),
                          _buildDataRow('Omeprazole 20mg', '987-654-321', '\$5.00', '100', '20'),
                          _buildDataRow('Lisinopril 10mg', '111-222-333', '\$15.00', '25', '5'),
                          _buildDataRow('Metformin 1000mg', '444-555-666', '\$12.00', '75', '15'),
                          _buildDataRow('Atorvastatin 40mg', '777-888-999', '\$20.00', '30', '8'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Sidebar Item
  Widget _buildSidebarItem(String title, {bool isActive = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: isActive ? Colors.grey[300] : Colors.transparent,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: isActive ? Colors.black : Colors.grey[700],
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  // Row for DataTable
  DataRow _buildDataRow(
      String name, String serial, String price, String qty, String threshold) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(
          Text(
            serial,
            style: const TextStyle(color: Colors.blue),
          ),
        ),
        DataCell(Text(price)),
        DataCell(Text(qty)),
        DataCell(Text(threshold)),
        DataCell(
          GestureDetector(
            onTap: () {
              // Add Edit logic here
            },
            child: const Text(
              'Edit',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
