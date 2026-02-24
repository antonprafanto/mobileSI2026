// DEMO 05: Form Registrasi Lengkap (Multi-Step Wizard)
//
// Proyek contoh form registrasi event dengan:
// - 3 langkah (Personal Info → Preferensi → Konfirmasi)
// - Step indicator/progress bar
// - Validasi per langkah sebelum pindah ke berikutnya
// - Kombinasi semua jenis input yang telah dipelajari
// - State management menggunakan setState (self-contained, tanpa package tambahan)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Registration Form',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
      home: const RegistrationPage(),
    );
  }
}

// ============================================================
// MODEL DATA
// ============================================================
class RegistrantData {
  // Step 1: Informasi Pribadi
  String name = '';
  String email = '';
  String phone = '';
  DateTime? birthDate;

  // Step 2: Preferensi Acara
  String ticketType = 'Regular';
  String session = 'Morning';
  List<String> interests = [];
  bool vegetarian = false;
  int guestCount = 1;
  String? city;

  // Getter untuk cek apakah data lengkap
  bool get isStep1Valid => name.isNotEmpty && email.isNotEmpty && birthDate != null;
  bool get isStep2Valid => interests.isNotEmpty && city != null;
}

// ============================================================
// HALAMAN UTAMA — Multi-Step Registration
// ============================================================
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // Langkah saat ini (0, 1, atau 2)
  int _currentStep = 0;

  // Data registrasi
  final RegistrantData _data = RegistrantData();

  // Form keys per step
  final _step1FormKey = GlobalKey<FormState>();
  final _step2FormKey = GlobalKey<FormState>();

  // Controllers Step 1
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();

  // Konstanta data
  final List<String> _sessions = ['Morning (08.00-12.00)', 'Afternoon (13.00-17.00)', 'Evening (18.00-21.00)'];
  final List<String> _interestOptions = ['AI & ML', 'Mobile Dev', 'Web Dev', 'Cloud', 'UI/UX Design', 'DevOps', 'Blockchain', 'Cybersecurity'];
  final List<String> _cities = ['Bandung', 'Jakarta', 'Surabaya', 'Yogyakarta', 'Semarang', 'Medan', 'Makassar'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  // Validasi dan pindah ke langkah berikutnya
  void _nextStep() {
    if (_currentStep == 0) {
      if (!_step1FormKey.currentState!.validate()) return;
      if (_data.birthDate == null) {
        _showSnack('Pilih tanggal lahir terlebih dahulu', isError: true);
        return;
      }
    } else if (_currentStep == 1) {
      if (!_step2FormKey.currentState!.validate()) return;
      if (_data.interests.isEmpty) {
        _showSnack('Pilih setidaknya 1 topik minat', isError: true);
        return;
      }
    }
    setState(() => _currentStep++);
  }

  void _prevStep() {
    if (_currentStep > 0) setState(() => _currentStep--);
  }

  void _submitForm() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('🎉 Registrasi Berhasil!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Halo, ${_data.name}!'),
            const SizedBox(height: 8),
            const Text('Registrasi Anda telah kami terima. Konfirmasi akan dikirim ke:', style: TextStyle(fontSize: 13)),
            Text(_data.email, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Selesai'),
          ),
        ],
      ),
    );
  }

  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: isError ? Colors.red : Colors.green,
    ));
  }

  // Format tanggal
  String _formatDate(DateTime d) {
    const months = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
    return '${d.day} ${months[d.month]} ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Registrasi Tech Summit 2026'),
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress Header
          _buildProgressHeader(),

          // Konten form
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _currentStep == 0
                    ? _buildStep1(key: const ValueKey(0))
                    : _currentStep == 1
                        ? _buildStep2(key: const ValueKey(1))
                        : _buildStep3(key: const ValueKey(2)),
              ),
            ),
          ),

          // Navigation buttons
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER PROGRESS
  // ============================================================
  Widget _buildProgressHeader() {
    final steps = ['Info Pribadi', 'Preferensi', 'Konfirmasi'];
    return Container(
      color: const Color(0xFF6C63FF),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Row(
        children: List.generate(steps.length, (i) {
          final isActive = i == _currentStep;
          final isDone = i < _currentStep;
          return Expanded(
            child: Row(
              children: [
                if (i > 0)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: isDone ? Colors.white : Colors.white.withOpacity(0.3),
                    ),
                  ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDone
                            ? Colors.green
                            : isActive
                                ? Colors.white
                                : Colors.white.withOpacity(0.3),
                        border: isActive ? Border.all(color: Colors.white, width: 2) : null,
                      ),
                      child: Center(
                        child: isDone
                            ? const Icon(Icons.check, color: Colors.white, size: 18)
                            : Text(
                                '${i + 1}',
                                style: TextStyle(
                                  color: isActive ? const Color(0xFF6C63FF) : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      steps[i],
                      style: TextStyle(
                        color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
                        fontSize: 11,
                        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                if (i < steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: i < _currentStep ? Colors.white : Colors.white.withOpacity(0.3),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ============================================================
  // STEP 1: INFORMASI PRIBADI
  // ============================================================
  Widget _buildStep1({Key? key}) {
    return Form(
      key: _step1FormKey,
      child: Column(
        key: key,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Informasi Pribadi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('Lengkapi data diri Anda',
              style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),

          // Nama
          TextFormField(
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Nama Lengkap *',
              prefixIcon: Icon(Icons.person_outline),
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Nama wajib diisi';
              if (v.trim().length < 3) return 'Nama minimal 3 karakter';
              return null;
            },
            onChanged: (v) => _data.name = v,
          ),
          const SizedBox(height: 14),

          // Email
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email *',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Email wajib diisi';
              if (!RegExp(r'^[\w\-.]+@[\w\-]+\.\w{2,}$').hasMatch(v)) {
                return 'Format email tidak valid';
              }
              return null;
            },
            onChanged: (v) => _data.email = v,
          ),
          const SizedBox(height: 14),

          // No. HP
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9+\- ]'))],
            decoration: const InputDecoration(
              labelText: 'No. HP *',
              prefixIcon: Icon(Icons.phone_outlined),
              hintText: '08123456789',
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'No. HP wajib diisi';
              if (v.replaceAll(RegExp(r'[\s\-]'), '').length < 10) {
                return 'No. HP tidak valid';
              }
              return null;
            },
            onChanged: (v) => _data.phone = v,
          ),
          const SizedBox(height: 14),

          // Tanggal Lahir — DatePicker
          TextFormField(
            controller: _birthDateController,
            readOnly: true,
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime(2000),
                firstDate: DateTime(1940),
                lastDate: DateTime.now().subtract(const Duration(days: 365 * 17)),
                helpText: 'Pilih Tanggal Lahir (min. 17 tahun)',
              );
              if (picked != null) {
                setState(() {
                  _data.birthDate = picked;
                  _birthDateController.text = _formatDate(picked);
                });
              }
            },
            decoration: const InputDecoration(
              labelText: 'Tanggal Lahir *',
              prefixIcon: Icon(Icons.cake_outlined),
              suffixIcon: Icon(Icons.calendar_today, size: 18),
              hintText: 'Klik untuk memilih',
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STEP 2: PREFERENSI ACARA
  // ============================================================
  Widget _buildStep2({Key? key}) {
    return Form(
      key: _step2FormKey,
      child: Column(
        key: key,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Preferensi Acara',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('Sesuaikan pengalaman Anda',
              style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),

          // Jenis Tiket — Radio
          const Text('Jenis Tiket *', style: TextStyle(fontWeight: FontWeight.w600)),
          ...['Regular (Gratis)', 'VIP (Rp 150.000)', 'VVIP (Rp 350.000)'].map((t) {
            final type = t.split(' ')[0];
            return RadioListTile<String>(
              title: Text(t),
              value: type,
              groupValue: _data.ticketType,
              onChanged: (v) => setState(() => _data.ticketType = v!),
              contentPadding: EdgeInsets.zero,
              dense: true,
              activeColor: const Color(0xFF6C63FF),
            );
          }),
          const SizedBox(height: 14),

          // Sesi — Dropdown
          DropdownButtonFormField<String>(
            value: _data.session,
            decoration: const InputDecoration(
              labelText: 'Pilih Sesi *',
              prefixIcon: Icon(Icons.schedule),
            ),
            items: _sessions
                .map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 13))))
                .toList(),
            onChanged: (v) => setState(() => _data.session = v!),
          ),
          const SizedBox(height: 14),

          // Kota — Dropdown
          DropdownButtonFormField<String>(
            value: _data.city,
            decoration: const InputDecoration(
              labelText: 'Kota Asal *',
              prefixIcon: Icon(Icons.location_on_outlined),
            ),
            hint: const Text('Pilih kota'),
            items: _cities.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (v) => setState(() => _data.city = v),
            validator: (v) => v == null ? 'Pilih kota asal' : null,
          ),
          const SizedBox(height: 14),

          // Minat — Multi-select Chip
          const Text('Topik Minat * (min. 1)', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: _interestOptions.map((i) {
              final selected = _data.interests.contains(i);
              return FilterChip(
                label: Text(i, style: const TextStyle(fontSize: 12)),
                selected: selected,
                onSelected: (v) {
                  setState(() {
                    if (v) _data.interests.add(i);
                    else _data.interests.remove(i);
                  });
                },
                selectedColor: const Color(0xFF6C63FF).withOpacity(0.2),
                checkmarkColor: const Color(0xFF6C63FF),
              );
            }).toList(),
          ),
          const SizedBox(height: 14),

          // Jumlah Tamu — Slider
          Text('Jumlah Tamu: ${_data.guestCount}',
              style: const TextStyle(fontWeight: FontWeight.w600)),
          Slider(
            value: _data.guestCount.toDouble(),
            min: 1,
            max: 5,
            divisions: 4,
            label: '${_data.guestCount} orang',
            activeColor: const Color(0xFF6C63FF),
            onChanged: (v) => setState(() => _data.guestCount = v.round()),
          ),
          const SizedBox(height: 8),

          // Vegetarian — Switch
          SwitchListTile(
            title: const Text('Menu Vegetarian'),
            subtitle: const Text('Tandai jika Anda memerlukan menu vegetarian'),
            value: _data.vegetarian,
            onChanged: (v) => setState(() => _data.vegetarian = v),
            activeColor: const Color(0xFF6C63FF),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STEP 3: KONFIRMASI
  // ============================================================
  Widget _buildStep3({Key? key}) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Konfirmasi Pendaftaran',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        const Text('Periksa kembali data Anda', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 20),

        _confirmCard(
          title: 'Informasi Pribadi',
          icon: Icons.person,
          rows: [
            ['Nama', _data.name],
            ['Email', _data.email],
            ['No. HP', _data.phone],
            ['Tanggal Lahir', _data.birthDate != null ? _formatDate(_data.birthDate!) : '-'],
          ],
        ),
        const SizedBox(height: 12),

        _confirmCard(
          title: 'Preferensi Acara',
          icon: Icons.event,
          rows: [
            ['Jenis Tiket', _data.ticketType],
            ['Sesi', _data.session],
            ['Kota', _data.city ?? '-'],
            ['Minat', _data.interests.join(', ')],
            ['Jumlah Tamu', '${_data.guestCount} orang'],
            ['Vegetarian', _data.vegetarian ? 'Ya' : 'Tidak'],
          ],
        ),

        const SizedBox(height: 20),
        const Text(
          '✅ Dengan menekan "Daftar Sekarang", Anda menyetujui syarat dan ketentuan pendaftaran acara Tech Summit 2026.',
          style: TextStyle(color: Colors.grey, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _confirmCard({
    required String title,
    required IconData icon,
    required List<List<String>> rows,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(icon, color: const Color(0xFF6C63FF), size: 18),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ]),
            const Divider(height: 16),
            ...rows.map((r) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 110, child: Text(r[0], style: const TextStyle(color: Colors.grey, fontSize: 13))),
                  Expanded(child: Text(r[1], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13))),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // TOMBOL NAVIGASI
  // ============================================================
  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -3))],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _prevStep,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('← Kembali'),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _currentStep < 2 ? _nextStep : _submitForm,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, 50),
                backgroundColor: const Color(0xFF6C63FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                _currentStep < 2 ? 'Lanjut →' : '🎉 Daftar Sekarang',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
