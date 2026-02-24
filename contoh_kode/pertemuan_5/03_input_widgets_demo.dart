// DEMO 03: Input Widget Lanjutan
//
// Topik yang dibahas:
// - Checkbox & CheckboxListTile (pilihan ganda)
// - Radio & RadioListTile (pilihan tunggal)
// - Switch & SwitchListTile (toggle on/off)
// - Slider (nilai dalam rentang)
// - RangeSlider (dua nilai, min dan maks)
// - DropdownButton & DropdownButtonFormField
// - Dropdown berantai (kota bergantung pada provinsi)

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Input Widgets Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const InputWidgetsDemoPage(),
    );
  }
}

class InputWidgetsDemoPage extends StatefulWidget {
  const InputWidgetsDemoPage({super.key});

  @override
  State<InputWidgetsDemoPage> createState() => _InputWidgetsDemoPageState();
}

class _InputWidgetsDemoPageState extends State<InputWidgetsDemoPage> {
  // ============================================================
  // STATE VARIABLES
  // ============================================================

  // Checkbox
  bool _agreeTerms = false;
  final List<String> _allSkills = ['Flutter', 'Dart', 'React Native', 'Android', 'iOS', 'Firebase'];
  final List<String> _selectedSkills = [];

  // Radio
  String _gender = 'Tidak disebutkan';
  String _shirtSize = 'M';

  // Switch
  bool _emailNotif = true;
  bool _smsNotif = false;
  bool _pushNotif = true;

  // Slider
  double _experience = 1.0;
  RangeValues _salaryRange = const RangeValues(5000000, 15000000);

  // Dropdown
  String? _selectedProvince;
  String? _selectedCity;
  String? _selectedRole = 'Mahasiswa';

  final Map<String, List<String>> _citiesByProvince = {
    'Jawa Barat': ['Bandung', 'Bekasi', 'Bogor', 'Depok', 'Cimahi', 'Tasikmalaya'],
    'DKI Jakarta': ['Jakarta Pusat', 'Jakarta Barat', 'Jakarta Timur', 'Jakarta Selatan', 'Jakarta Utara'],
    'Jawa Tengah': ['Semarang', 'Solo', 'Magelang', 'Salatiga', 'Purwokerto'],
    'Jawa Timur': ['Surabaya', 'Malang', 'Kediri', 'Blitar', 'Madiun'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo 03: Input Widgets Lanjutan'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========================================
            // 1. CHECKBOX
            // ========================================
            _sectionCard(
              title: '1. Checkbox',
              color: Colors.orange,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Single checkbox
                  CheckboxListTile(
                    title: const Text('Saya setuju dengan Syarat & Ketentuan'),
                    subtitle: const Text('Wajib disetujui untuk melanjutkan'),
                    value: _agreeTerms,
                    onChanged: (val) => setState(() => _agreeTerms = val ?? false),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Divider(),
                  // Multiple checkbox
                  const Text('Pilih keahlian Anda (boleh lebih dari satu):',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  Wrap(
                    children: _allSkills.map((skill) {
                      final isSelected = _selectedSkills.contains(skill);
                      return FilterChip(
                        label: Text(skill),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedSkills.add(skill);
                            } else {
                              _selectedSkills.remove(skill);
                            }
                          });
                        },
                        selectedColor: Colors.orange.shade100,
                        checkmarkColor: Colors.orange.shade800,
                      );
                    }).toList(),
                  ),
                  if (_selectedSkills.isNotEmpty)
                    Text('✅ Dipilih: ${_selectedSkills.join(', ')}',
                        style: const TextStyle(color: Colors.green)),
                ],
              ),
            ),

            // ========================================
            // 2. RADIO BUTTON
            // ========================================
            _sectionCard(
              title: '2. Radio Button',
              color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gender — pakai Row
                  const Text('Jenis Kelamin:', style: TextStyle(fontWeight: FontWeight.w500)),
                  Row(
                    children: ['Laki-laki', 'Perempuan', 'Tidak disebutkan'].map((g) {
                      return Expanded(
                        child: RadioListTile<String>(
                          title: Text(g, style: const TextStyle(fontSize: 12)),
                          value: g,
                          groupValue: _gender,
                          onChanged: (val) => setState(() => _gender = val!),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          activeColor: Colors.blue,
                        ),
                      );
                    }).toList(),
                  ),
                  const Divider(),
                  // Ukuran baju — pakai column
                  const Text('Ukuran Kaos:', style: TextStyle(fontWeight: FontWeight.w500)),
                  Wrap(
                    children: ['XS', 'S', 'M', 'L', 'XL', 'XXL'].map((size) {
                      return SizedBox(
                        width: 80,
                        child: RadioListTile<String>(
                          title: Text(size),
                          value: size,
                          groupValue: _shirtSize,
                          onChanged: (val) => setState(() => _shirtSize = val!),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          activeColor: Colors.blue,
                        ),
                      );
                    }).toList(),
                  ),
                  Text('Dipilih: $_gender | Ukuran: $_shirtSize',
                      style: const TextStyle(color: Colors.blue)),
                ],
              ),
            ),

            // ========================================
            // 3. SWITCH
            // ========================================
            _sectionCard(
              title: '3. Switch',
              color: Colors.green,
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Notifikasi Email'),
                    subtitle: const Text('Terima update via email'),
                    value: _emailNotif,
                    onChanged: (val) => setState(() => _emailNotif = val),
                    activeColor: Colors.green,
                    secondary: const Icon(Icons.email),
                  ),
                  SwitchListTile(
                    title: const Text('Notifikasi SMS'),
                    subtitle: const Text('Terima update via SMS'),
                    value: _smsNotif,
                    onChanged: (val) => setState(() => _smsNotif = val),
                    activeColor: Colors.green,
                    secondary: const Icon(Icons.sms),
                  ),
                  SwitchListTile(
                    title: const Text('Push Notification'),
                    subtitle: const Text('Notifikasi di aplikasi'),
                    value: _pushNotif,
                    onChanged: (val) => setState(() => _pushNotif = val),
                    activeColor: Colors.green,
                    secondary: const Icon(Icons.notifications),
                  ),
                ].map((tile) => Column(children: [tile, const Divider(height: 0)])).toList().expand((x) => x).toList()..removeLast(),
              ),
            ),

            // ========================================
            // 4. SLIDER
            // ========================================
            _sectionCard(
              title: '4. Slider & RangeSlider',
              color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Single Slider
                  Text(
                    'Pengalaman: ${_experience.round()} tahun',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Slider(
                    value: _experience,
                    min: 0,
                    max: 10,
                    divisions: 10,
                    label: '${_experience.round()} thn',
                    activeColor: Colors.red,
                    onChanged: (val) => setState(() => _experience = val),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('0 thn', style: TextStyle(fontSize: 12)),
                      Text('Fresh Graduate', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text('10 thn', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  const Divider(),

                  // Range Slider
                  Text(
                    'Ekspektasi Gaji: Rp ${_formatRupiah(_salaryRange.start)} - Rp ${_formatRupiah(_salaryRange.end)}',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  RangeSlider(
                    values: _salaryRange,
                    min: 3000000,
                    max: 30000000,
                    divisions: 27,
                    labels: RangeLabels(
                      'Rp ${_formatRupiah(_salaryRange.start)}',
                      'Rp ${_formatRupiah(_salaryRange.end)}',
                    ),
                    activeColor: Colors.red,
                    onChanged: (vals) => setState(() => _salaryRange = vals),
                  ),
                ],
              ),
            ),

            // ========================================
            // 5. DROPDOWN
            // ========================================
            _sectionCard(
              title: '5. Dropdown & Dropdown Berantai',
              color: Colors.teal,
              child: Column(
                children: [
                  // Simple dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedRole,
                    decoration: const InputDecoration(
                      labelText: 'Peran',
                      prefixIcon: Icon(Icons.work),
                      border: OutlineInputBorder(),
                    ),
                    items: ['Mahasiswa', 'Dosen', 'Profesional', 'Wirausaha']
                        .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                        .toList(),
                    onChanged: (val) => setState(() => _selectedRole = val),
                  ),
                  const SizedBox(height: 12),

                  // Dropdown berantai: Provinsi → Kota
                  DropdownButtonFormField<String>(
                    value: _selectedProvince,
                    decoration: const InputDecoration(
                      labelText: 'Provinsi',
                      prefixIcon: Icon(Icons.map),
                      border: OutlineInputBorder(),
                    ),
                    hint: const Text('Pilih provinsi'),
                    items: _citiesByProvince.keys
                        .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedProvince = val;
                        _selectedCity = null; // Reset kota
                      });
                    },
                  ),
                  const SizedBox(height: 12),

                  DropdownButtonFormField<String>(
                    key: ValueKey(_selectedProvince), // rebuilt saat provinsi berubah
                    value: _selectedCity,
                    decoration: InputDecoration(
                      labelText: 'Kota/Kabupaten',
                      prefixIcon: const Icon(Icons.location_city),
                      border: const OutlineInputBorder(),
                      fillColor: _selectedProvince == null ? Colors.grey.shade100 : null,
                      filled: _selectedProvince == null,
                    ),
                    hint: Text(_selectedProvince == null
                        ? 'Pilih provinsi dahulu'
                        : 'Pilih kota'),
                    items: _selectedProvince != null
                        ? _citiesByProvince[_selectedProvince]!
                            .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                            .toList()
                        : [],
                    onChanged: _selectedProvince != null
                        ? (val) => setState(() => _selectedCity = val)
                        : null,
                  ),

                  if (_selectedCity != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        '📍 Lokasi: $_selectedCity, $_selectedProvince',
                        style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.w500),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper: card section
  Widget _sectionCard({
    required String title,
    required Color color,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 18,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color.withOpacity(0.9),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: child,
          ),
        ],
      ),
    );
  }

  String _formatRupiah(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}jt';
    }
    return value.toStringAsFixed(0);
  }
}
