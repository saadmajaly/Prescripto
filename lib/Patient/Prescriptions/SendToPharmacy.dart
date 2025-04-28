// lib/pages/select_pharmacy_page.dart
import 'SentSuccessfully.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

// your generated Drift database
import 'package:prescripto/data/database.dart';

class SendToPharmacy extends StatefulWidget {
  final AppDatabase database;
  const SendToPharmacy(this.database, { Key? key }) : super(key: key);

  @override
  _SendToPharmacyState createState() => _SendToPharmacyState();
}

class _SendToPharmacyState extends State<SendToPharmacy> {
  // ─── Map state ─────────────────────────────────────
  late final MapController _mapController;
  LatLng _mapCenter = LatLng(31.95, 35.90); // default from your seed data
  double _mapZoom = 13.0;

  // ─── Data + filters ───────────────────────────────
  List<Pharmacy> _all = [];
  List<Pharmacy> _filtered = [];
  int? _selectedId;

  String _insuranceFilter = 'All';
  bool _pickupOnly = false;
  final _searchCtl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _searchCtl.addListener(_applyFilters);

    // stream all pharmacies from Drift
    widget.database
        .select(widget.database.pharmacies)
        .watch()
        .listen((rows) {
      setState(() => _all = rows);
      _applyFilters();
    });
  }

  void _applyFilters() {
    final q = _searchCtl.text.toLowerCase();
    final matches = _all.where((p) {
      final nameMatch = p.name.toLowerCase().contains(q);
      final addrMatch = (p.address ?? '').toLowerCase().contains(q);
      final insMatch = _insuranceFilter == 'All' ||
          (p.acceptsInsurance && _insuranceFilter == 'Accepts Insurance');
      // stubbed: wire up real open-hours / pickup flags if you add those fields
      return (nameMatch || addrMatch) && insMatch;
    }).toList();

    setState(() => _filtered = matches);
  }

  Future<void> _locateMe() async {
    try {
      final pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      _mapCenter = LatLng(pos.latitude, pos.longitude);
      _mapZoom = 15.0;
      _mapController.move(_mapCenter, _mapZoom);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send to Pharmacy'),
        leading: CloseButton(),
      ),
      body: Column(
        children: [
          // ─── Search bar ─────────────────────
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchCtl,
              decoration: InputDecoration(
                hintText: 'Search for a pharmacy',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),

          // ─── Filters ────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _insuranceFilter,
                    items: ['All', 'Accepts Insurance']
                        .map((v) => DropdownMenuItem(
                      value: v,
                      child: Text(v),
                    ))
                        .toList(),
                    onChanged: (v) {
                      _insuranceFilter = v!;
                      _applyFilters();
                    },
                  ),
                ),
                SizedBox(width: 8),
                FilterChip(
                  label: Text('Pickup'),
                  selected: _pickupOnly,
                  onSelected: (sel) {
                    _pickupOnly = sel;
                    _applyFilters();
                  },
                ),
              ],
            ),
          ),

          // ─── Map + List ─────────────────────
          Expanded(
            child: Column(
              children: [
                // —— Map ——
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          initialCenter: _mapCenter,  // v8 uses initialCenter/initialZoom :contentReference[oaicite:0]{index=0}
                          initialZoom: _mapZoom,
                          onPositionChanged: (pos, _) {
                            if (pos.center != null && pos.zoom != null) {
                              setState(() {
                                _mapCenter = pos.center!;
                                _mapZoom = pos.zoom!;
                              });
                            }
                          },
                        ),
                        children: [                  // v8 layers go into children :contentReference[oaicite:1]{index=1}
                          TileLayer(
                            urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: ['a', 'b', 'c'],
                            userAgentPackageName: 'com.example.prescripto',
                          ),
                          MarkerLayer(
                            markers: _filtered.map((p) {
                              final isSel = p.pharmacyId == _selectedId;
                              final lat = p.latitude ?? 0.0;
                              final lng = p.longitude ?? 0.0;
                              return Marker(
                                width: isSel ? 48 : 36,
                                height: isSel ? 48 : 36,
                                point: LatLng(lat, lng),
                                child: GestureDetector(
                                  onTap: () =>
                                      setState(() => _selectedId = p.pharmacyId),
                                  child: Icon(
                                    Icons.location_on,
                                    size: isSel ? 48 : 36,
                                    color: isSel
                                        ? Theme.of(ctx).primaryColor
                                        : Colors.red,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),

                      // —— Zoom & locate buttons ——
                      Positioned(
                        bottom: 12,
                        right: 12,
                        child: Column(
                          children: [
                            FloatingActionButton(
                              mini: true,
                              child: Icon(Icons.add),
                              onPressed: () {
                                _mapController.move(
                                  _mapCenter,
                                  (_mapZoom + 1).clamp(1.0, 18.0),
                                );
                              },
                            ),
                            SizedBox(height: 8),
                            FloatingActionButton(
                              mini: true,
                              child: Icon(Icons.remove),
                              onPressed: () {
                                _mapController.move(
                                  _mapCenter,
                                  (_mapZoom - 1).clamp(1.0, 18.0),
                                );
                              },
                            ),
                            SizedBox(height: 8),
                            FloatingActionButton(
                              mini: true,
                              child: Icon(Icons.my_location),
                              onPressed: _locateMe,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // —— List header ——
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Pharmacies',
                      style: Theme.of(ctx).textTheme.titleMedium,
                    ),
                  ),
                ),

                // —— Pharmacy list ——
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: _filtered.length,
                    itemBuilder: (_, i) {
                      final p = _filtered[i];
                      final sel = p.pharmacyId == _selectedId;
                      return ListTile(
                        title: Text(p.name),
                        subtitle: Text(
                          'Open now · ${p.acceptsInsurance ? 'Accepts insurance' : 'No insurance'}',
                        ),
                        trailing: ElevatedButton(
                          onPressed: () =>
                              setState(() => _selectedId = p.pharmacyId),

                          child: Text(sel ? 'Selected' : 'Select',
                          style: TextStyle(color: sel
                          ? Colors.white60
                          : Colors.white),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: sel
                                ? Colors.grey.shade400
                                : Colors.blue,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // ─── Bottom CTA ─────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedId == null
                      ? null
                      : () {
                    final chosen = _all.firstWhere(
                            (p) => p.pharmacyId == _selectedId);
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PrescriptionSentSuccessfully())
                    );
                  },
                  child: Text('Send to selected Pharmacy'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
