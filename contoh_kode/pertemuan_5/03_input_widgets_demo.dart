// =====================================================
// PERTEMUAN 5 - DEMO 03: Input Widgets Showcase
// =====================================================
// File: 03_input_widgets_demo.dart
//
// CARA PAKAI:
// 1. Buat Flutter project baru: flutter create demo_app
// 2. Replace isi lib/main.dart dengan code ini
// 3. Run: flutter run
//
// TOPIK:
// - Checkbox / CheckboxListTile
// - Radio / RadioListTile
// - Switch / SwitchListTile
// - Slider
// - DropdownButtonFormField
// =====================================================

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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      home: const InputWidgetsPage(),
    );
  }
}

class InputWidgetsPage extends StatefulWidget {
  const InputWidgetsPage({super.key});

  @override
  State<InputWidgetsPage> createState() => _InputWidgetsPageState();
}

class _InputWidgetsPageState extends State<InputWidgetsPage> {
  // Checkbox
  bool _agreeTerms = false;
  bool _subscribeNewsletter = false;
  bool _shareData = false;

  // Radio
  String _selectedGender = 'Laki-laki';
  String _selectedPriority = 'Medium';

  // Switch
  bool _darkMode = false;
  bool _notifications = true;
  bool _locationAccess = false;

  // Slider
  double _satisfaction = 5.0;
  double _fontSize = 16.0;
  RangeValues _ageRange = const RangeValues(18, 30);

  // Dropdown
  String? _selectedProdi;
  String? _selectedSemester;

  final List<String> _prodiList = [
    'Teknik Informatika',
    'Sistem Informasi',
    'Teknik Komputer',
    'Data Science',
    'Desain Komunikasi Visual',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎛️ Input Widgets Showcase'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // 1. CHECKBOX
            // ==========================================
            _buildSectionHeader('☑️ Checkbox', 'Boolean ya/tidak'),

            CheckboxListTile(
              title: const Text('Saya setuju dengan syarat & ketentuan'),
              subtitle: const Text('Wajib'),
              value: _agreeTerms,
              onChanged: (v) => setState(() => _agreeTerms = v ?? false),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.green,
            ),
            CheckboxListTile(
              title: const Text('Berlangganan newsletter'),
              subtitle: const Text('Opsional'),
              value: _subscribeNewsletter,
              onChanged: (v) => setState(() => _subscribeNewsletter = v ?? false),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('Izinkan berbagi data anonim'),
              value: _shareData,
              onChanged: (v) => setState(() => _shareData = v ?? false),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const Divider(height: 32),

            // ==========================================
            // 2. RADIO
            // ==========================================
            _buildSectionHeader('🔘 Radio', 'Pilih SATU dari beberapa opsi'),

            const Text('Jenis Kelamin:', style: TextStyle(fontWeight: FontWeight.w500)),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Laki-laki'),
                    value: 'Laki-laki',
                    groupValue: _selectedGender,
                    onChanged: (v) => setState(() => _selectedGender = v!),
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Perempuan'),
                    value: 'Perempuan',
                    groupValue: _selectedGender,
                    onChanged: (v) => setState(() => _selectedGender = v!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            const Text('Prioritas:', style: TextStyle(fontWeight: FontWeight.w500)),
            Wrap(
              children: ['Low', 'Medium', 'High', 'Critical'].map((p) {
                return SizedBox(
                  width: 150,
                  child: RadioListTile<String>(
                    title: Text(p),
                    value: p,
                    groupValue: _selectedPriority,
                    onChanged: (v) => setState(() => _selectedPriority = v!),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                );
              }).toList(),
            ),
            const Divider(height: 32),

            // ==========================================
            // 3. SWITCH
            // ==========================================
            _buildSectionHeader('🔀 Switch', 'Toggle on/off'),

            SwitchListTile(
              title: const Text('Dark Mode'),
              subtitle: Text(_darkMode ? 'Aktif' : 'Nonaktif'),
              value: _darkMode,
              onChanged: (v) => setState(() => _darkMode = v),
              secondary: Icon(_darkMode ? Icons.dark_mode : Icons.light_mode),
            ),
            SwitchListTile(
              title: const Text('Notifikasi Push'),
              subtitle: Text(_notifications ? 'Aktif' : 'Nonaktif'),
              value: _notifications,
              onChanged: (v) => setState(() => _notifications = v),
              secondary: const Icon(Icons.notifications),
            ),
            SwitchListTile(
              title: const Text('Akses Lokasi'),
              subtitle: Text(_locationAccess ? 'Diizinkan' : 'Ditolak'),
              value: _locationAccess,
              onChanged: (v) => setState(() => _locationAccess = v),
              secondary: const Icon(Icons.location_on),
            ),
            const Divider(height: 32),

            // ==========================================
            // 4. SLIDER
            // ==========================================
            _buildSectionHeader('🎚️ Slider', 'Pilih nilai dari range'),

            const Text('Tingkat Kepuasan:'),
            Slider(
              value: _satisfaction,
              min: 0,
              max: 10,
              divisions: 10,
              label: '${_satisfaction.round()}',
              onChanged: (v) => setState(() => _satisfaction = v),
            ),
            Text('Nilai: ${_satisfaction.round()}/10',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),

            const Text('Preview Font Size:'),
            Slider(
              value: _fontSize,
              min: 10,
              max: 36,
              divisions: 26,
              label: '${_fontSize.round()}px',
              onChanged: (v) => setState(() => _fontSize = v),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey.shade100,
              child: Text(
                'The quick brown fox jumps over the lazy dog',
                style: TextStyle(fontSize: _fontSize),
              ),
            ),
            const SizedBox(height: 16),

            const Text('Range Usia Target:'),
            RangeSlider(
              values: _ageRange,
              min: 10,
              max: 60,
              divisions: 50,
              labels: RangeLabels(
                '${_ageRange.start.round()} thn',
                '${_ageRange.end.round()} thn',
              ),
              onChanged: (v) => setState(() => _ageRange = v),
            ),
            Text('${_ageRange.start.round()} - ${_ageRange.end.round()} tahun'),
            const Divider(height: 32),

            // ==========================================
            // 5. DROPDOWN
            // ==========================================
            _buildSectionHeader('📋 Dropdown', 'Pilih dari daftar'),

            DropdownButtonFormField<String>(
              initialValue: _selectedProdi,
              decoration: const InputDecoration(
                labelText: 'Program Studi',
                prefixIcon: Icon(Icons.school),
                border: OutlineInputBorder(),
              ),
              hint: const Text('Pilih Program Studi'),
              items: _prodiList.map((prodi) {
                return DropdownMenuItem(value: prodi, child: Text(prodi));
              }).toList(),
              onChanged: (v) => setState(() => _selectedProdi = v),
              validator: (v) => v == null ? 'Wajib pilih' : null,
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: _selectedSemester,
              decoration: const InputDecoration(
                labelText: 'Semester',
                prefixIcon: Icon(Icons.calendar_month),
                border: OutlineInputBorder(),
              ),
              hint: const Text('Pilih Semester'),
              items: List.generate(8, (i) => '${i + 1}').map((s) {
                return DropdownMenuItem(value: s, child: Text('Semester $s'));
              }).toList(),
              onChanged: (v) => setState(() => _selectedSemester = v),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // SUMMARY
            // ==========================================
            _buildSectionHeader('📊 Ringkasan', 'Semua nilai input'),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('☑️ Setuju T&C: $_agreeTerms'),
                    Text('📧 Newsletter: $_subscribeNewsletter'),
                    Text('📊 Share Data: $_shareData'),
                    const Divider(),
                    Text('👤 Gender: $_selectedGender'),
                    Text('⚡ Priority: $_selectedPriority'),
                    const Divider(),
                    Text('🌙 Dark Mode: $_darkMode'),
                    Text('🔔 Notifikasi: $_notifications'),
                    Text('📍 Lokasi: $_locationAccess'),
                    const Divider(),
                    Text('⭐ Kepuasan: ${_satisfaction.round()}/10'),
                    Text('📏 Font: ${_fontSize.round()}px'),
                    Text('👥 Usia: ${_ageRange.start.round()}-${_ageRange.end.round()} thn'),
                    const Divider(),
                    Text('🎓 Prodi: ${_selectedProdi ?? "-"}'),
                    Text('📅 Semester: ${_selectedSemester ?? "-"}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(subtitle, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
