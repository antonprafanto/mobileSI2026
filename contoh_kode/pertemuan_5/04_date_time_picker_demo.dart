// DEMO 04: DatePicker & TimePicker
//
// Topik yang dibahas:
// - showDatePicker() — memilih tanggal
// - showTimePicker() — memilih waktu
// - showDateRangePicker() — memilih rentang tanggal
// - Kustomisasi theme picker
// - Format tampilan tanggal & waktu dalam Bahasa Indonesia
// - Integrasi DatePicker ke dalam Form dengan TextFormField

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DateTimePicker Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
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
  // State untuk menyimpan hasil picker
  DateTime? _birthDate;
  TimeOfDay? _eventTime;
  DateTimeRange? _tripRange;
  DateTime? _meetingDateTime;

  // Controller untuk tampilan di TextField
  final _birthDateController = TextEditingController();
  final _eventTimeController = TextEditingController();
  final _meetingController = TextEditingController();

  // Nama bulan dalam Bahasa Indonesia
  static const List<String> _months = [
    '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];

  static const List<String> _days = [
    '', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'
  ];

  @override
  void dispose() {
    _birthDateController.dispose();
    _eventTimeController.dispose();
    _meetingController.dispose();
    super.dispose();
  }

  // ① Format tanggal ke Bahasa Indonesia
  String _formatDate(DateTime date) {
    return '${date.day} ${_months[date.month]} ${date.year}';
  }

  // Format tanggal dengan hari
  String _formatDateFull(DateTime date) {
    return '${_days[date.weekday]}, ${date.day} ${_months[date.month]} ${date.year}';
  }

  // Hitung umur dari tanggal lahir
  int _calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  // ② showDatePicker untuk tanggal lahir
  Future<void> _pickBirthDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      // Tanggal awal yang ditampilkan
      initialDate: _birthDate ?? DateTime(2000, 1, 1),
      // Batas terlama yang bisa dipilih
      firstDate: DateTime(1940),
      // Batas terakhir (tidak bisa pilih masa depan untuk tanggal lahir)
      lastDate: DateTime.now(),
      helpText: 'Pilih Tanggal Lahir',
      cancelText: 'Batal',
      confirmText: 'Pilih',
      // Kustomisasi tampilan
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.indigo.shade600,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _birthDate = picked;
        _birthDateController.text = _formatDate(picked);
      });
    }
  }

  // ③ showTimePicker untuk waktu acara
  Future<void> _pickEventTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _eventTime ?? TimeOfDay.now(),
      helpText: 'Pilih Waktu Acara',
      cancelText: 'Batal',
      confirmText: 'Pilih',
      // Mode: pengaturan jam dan menit
      initialEntryMode: TimePickerEntryMode.dial, // atau .input untuk ketik manual
    );

    if (picked != null) {
      setState(() {
        _eventTime = picked;
        // Format: HH:MM WIB
        final hour = picked.hour.toString().padLeft(2, '0');
        final minute = picked.minute.toString().padLeft(2, '0');
        _eventTimeController.text = '$hour:$minute WIB';
      });
    }
  }

  // ④ showDateRangePicker untuk trip/perjalanan
  Future<void> _pickTripRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      initialDateRange: _tripRange,
      helpText: 'Pilih Rentang Tanggal Perjalanan',
      cancelText: 'Batal',
      confirmText: 'Pilih',
      saveText: 'Simpan',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.indigo.shade600,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _tripRange = picked);
    }
  }

  // ⑤ Kombinasi DatePicker + TimePicker untuk jadwal rapat
  Future<void> _pickMeetingDateTime() async {
    // Step 1: Pilih tanggal
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _meetingDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: 'Pilih Tanggal Rapat',
    );

    if (date == null) return; // User batal

    // Step 2: Pilih waktu
    if (!mounted) return;
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _meetingDateTime != null
          ? TimeOfDay.fromDateTime(_meetingDateTime!)
          : const TimeOfDay(hour: 9, minute: 0),
      helpText: 'Pilih Waktu Rapat',
    );

    if (time == null) return;

    // Gabungkan tanggal dan waktu
    setState(() {
      _meetingDateTime = DateTime(
        date.year, date.month, date.day,
        time.hour, time.minute,
      );
      _meetingController.text =
          '${_formatDateFull(date)} pukul ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo 04: DatePicker & TimePicker'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ① Tanggal Lahir — showDatePicker
            _label('1. DatePicker — Tanggal Lahir'),
            TextFormField(
              controller: _birthDateController,
              readOnly: true, // Tidak bisa ketik manual
              onTap: _pickBirthDate, // Klik untuk buka picker
              decoration: InputDecoration(
                labelText: 'Tanggal Lahir',
                hintText: 'Klik untuk memilih',
                prefixIcon: const Icon(Icons.cake),
                suffixIcon: _birthDate != null
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _birthDate = null;
                            _birthDateController.clear();
                          });
                        },
                      )
                    : const Icon(Icons.calendar_today),
                border: const OutlineInputBorder(),
              ),
            ),
            if (_birthDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4),
                child: Text(
                  '🎂 Umur: ${_calculateAge(_birthDate!)} tahun',
                  style: TextStyle(
                    color: Colors.indigo.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // ② Waktu Acara — showTimePicker
            _label('2. TimePicker — Waktu Acara'),
            TextFormField(
              controller: _eventTimeController,
              readOnly: true,
              onTap: _pickEventTime,
              decoration: const InputDecoration(
                labelText: 'Waktu Acara',
                hintText: 'Klik untuk memilih waktu',
                prefixIcon: Icon(Icons.access_time),
                suffixIcon: Icon(Icons.schedule),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // ③ Rentang Tanggal — showDateRangePicker
            _label('3. DateRangePicker — Tanggal Perjalanan'),
            OutlinedButton.icon(
              onPressed: _pickTripRange,
              icon: const Icon(Icons.date_range),
              label: const Text('Pilih Tanggal Perjalanan'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            if (_tripRange != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('✈️ Berangkat: ${_formatDateFull(_tripRange!.start)}'),
                    Text('🏠 Kembali: ${_formatDateFull(_tripRange!.end)}'),
                    Text(
                      '📅 Durasi: ${_tripRange!.duration.inDays} hari',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 20),

            // ④ Date + Time — kombinasi untuk jadwal rapat
            _label('4. Kombinasi Date + Time — Jadwal Rapat'),
            TextFormField(
              controller: _meetingController,
              readOnly: true,
              onTap: _pickMeetingDateTime,
              decoration: const InputDecoration(
                labelText: 'Jadwal Rapat',
                hintText: 'Klik untuk memilih tanggal & waktu',
                prefixIcon: Icon(Icons.event),
                suffixIcon: Icon(Icons.calendar_month),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            // Info card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.indigo.shade200),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('📅 Rangkuman DatePicker:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('• showDatePicker()  →  pilih satu tanggal'),
                  Text('• showTimePicker()  →  pilih waktu'),
                  Text('• showDateRangePicker()  →  pilih rentang tanggal'),
                  Text('• Gunakan readOnly: true + onTap untuk TextField'),
                  Text('• Bisa dikustomisasi temanya dengan builder'),
                  Text('• Gabungkan Date+Time untuk jadwal lengkap'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.indigo,
        ),
      ),
    );
  }
}
