// =====================================================
// PERTEMUAN 5 - DEMO 04: DatePicker & TimePicker
// =====================================================
// File: 04_date_time_picker_demo.dart
//
// CARA PAKAI:
// 1. Buat Flutter project baru: flutter create demo_app
// 2. Replace isi lib/main.dart dengan code ini
// 3. Run: flutter run
//
// TOPIK:
// - showDatePicker
// - showTimePicker
// - Format tanggal manual
// - DatePicker di dalam Form (read-only TextFormField)
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
      title: 'DatePicker & TimePicker Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const DateTimePickerPage(),
    );
  }
}

class DateTimePickerPage extends StatefulWidget {
  const DateTimePickerPage({super.key});

  @override
  State<DateTimePickerPage> createState() => _DateTimePickerPageState();
}

class _DateTimePickerPageState extends State<DateTimePickerPage> {
  // Date & Time values
  DateTime? _birthDate;
  DateTime? _eventDate;
  TimeOfDay? _eventTime;
  DateTimeRange? _dateRange;

  // For Form integration
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  // ==========================================
  // FORMAT TANGGAL (tanpa package intl)
  // ==========================================
  String _formatDate(DateTime date) {
    final months = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    return '${date.day} ${months[date.month]} ${date.year}';
  }

  String _formatDateShort(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  // ==========================================
  // DATE PICKER
  // ==========================================
  Future<void> _pickBirthDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(2004, 1, 1),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      helpText: 'Pilih Tanggal Lahir',
      cancelText: 'Batal',
      confirmText: 'Pilih',
      fieldLabelText: 'Tanggal',
      fieldHintText: 'DD/MM/YYYY',
    );
    if (picked != null) {
      setState(() => _birthDate = picked);
    }
  }

  Future<void> _pickEventDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _eventDate ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: 'Pilih Tanggal Event',
      // Restrict selectable days (contoh: weekdays only)
      selectableDayPredicate: (DateTime day) {
        // Tidak bisa pilih Sabtu (6) dan Minggu (7)
        return day.weekday != DateTime.saturday &&
            day.weekday != DateTime.sunday;
      },
    );
    if (picked != null) {
      setState(() => _eventDate = picked);
    }
  }

  // ==========================================
  // TIME PICKER
  // ==========================================
  Future<void> _pickEventTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _eventTime ?? const TimeOfDay(hour: 9, minute: 0),
      helpText: 'Pilih Waktu Event',
      cancelText: 'Batal',
      confirmText: 'Pilih',
    );
    if (picked != null) {
      setState(() => _eventTime = picked);
    }
  }

  // ==========================================
  // DATE RANGE PICKER
  // ==========================================
  Future<void> _pickDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: _dateRange ??
          DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(const Duration(days: 7)),
          ),
      helpText: 'Pilih Rentang Tanggal',
      cancelText: 'Batal',
      confirmText: 'Pilih',
      saveText: 'Simpan',
    );
    if (picked != null) {
      setState(() => _dateRange = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📅 Date & Time Picker'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // 1. BASIC DATE PICKER
            // ==========================================
            _buildSectionHeader('1️⃣ DatePicker Basic', 'Pilih tanggal lahir'),

            ListTile(
              leading: const Icon(Icons.cake, color: Colors.pink),
              title: const Text('Tanggal Lahir'),
              subtitle: Text(
                _birthDate != null
                    ? _formatDate(_birthDate!)
                    : 'Belum dipilih — tap untuk pilih',
              ),
              trailing: const Icon(Icons.arrow_drop_down),
              onTap: _pickBirthDate,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade300),
              ),
            ),

            if (_birthDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 16),
                child: Text(
                  'Umur: ${DateTime.now().year - _birthDate!.year} tahun',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
            const SizedBox(height: 24),

            // ==========================================
            // 2. DATE PICKER WITH RESTRICTIONS
            // ==========================================
            _buildSectionHeader(
              '2️⃣ DatePicker + Restrictions',
              'Hanya hari kerja (Senin-Jumat)',
            ),

            ListTile(
              leading: const Icon(Icons.event, color: Colors.blue),
              title: const Text('Tanggal Event'),
              subtitle: Text(
                _eventDate != null
                    ? '${_formatDate(_eventDate!)} (${_getDayName(_eventDate!.weekday)})'
                    : 'Belum dipilih — Sabtu/Minggu disabled',
              ),
              trailing: const Icon(Icons.arrow_drop_down),
              onTap: _pickEventDate,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // 3. TIME PICKER
            // ==========================================
            _buildSectionHeader('3️⃣ TimePicker', 'Pilih waktu event'),

            ListTile(
              leading: const Icon(Icons.access_time, color: Colors.orange),
              title: const Text('Waktu Event'),
              subtitle: Text(
                _eventTime != null
                    ? _eventTime!.format(context)
                    : 'Belum dipilih — tap untuk pilih',
              ),
              trailing: const Icon(Icons.arrow_drop_down),
              onTap: _pickEventTime,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // 4. DATE RANGE PICKER
            // ==========================================
            _buildSectionHeader('4️⃣ DateRangePicker', 'Pilih rentang tanggal'),

            ListTile(
              leading: const Icon(Icons.date_range, color: Colors.green),
              title: const Text('Rentang Tanggal'),
              subtitle: Text(
                _dateRange != null
                    ? '${_formatDateShort(_dateRange!.start)} — ${_formatDateShort(_dateRange!.end)} '
                      '(${_dateRange!.duration.inDays} hari)'
                    : 'Belum dipilih — tap untuk pilih',
              ),
              trailing: const Icon(Icons.arrow_drop_down),
              onTap: _pickDateRange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // 5. DATE DI DALAM FORM (TextFormField)
            // ==========================================
            _buildSectionHeader(
              '5️⃣ DatePicker di Form',
              'Dengan TextFormField read-only + validasi',
            ),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Tanggal Acara *',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      hintText: 'Tap untuk pilih tanggal',
                    ),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().add(const Duration(days: 1)),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        _dateController.text = _formatDate(picked);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tanggal acara wajib diisi!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  TextFormField(
                    controller: _timeController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Waktu Acara *',
                      prefixIcon: Icon(Icons.access_time),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      hintText: 'Tap untuk pilih waktu',
                    ),
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: const TimeOfDay(hour: 9, minute: 0),
                      );
                      if (picked != null && context.mounted) {
                        _timeController.text = picked.format(context);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Waktu acara wajib diisi!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '✅ Acara: ${_dateController.text} pukul ${_timeController.text}',
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Validasi Form'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
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

  String _getDayName(int weekday) {
    const days = ['', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    return days[weekday];
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }
}
