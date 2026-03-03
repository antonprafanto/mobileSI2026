// =====================================================
// PERTEMUAN 5 - DEMO 05: Registration Form Complete
// =====================================================
// File: 05_registration_form_complete.dart
//
// CARA PAKAI:
// 1. Buat Flutter project baru: flutter create demo_app
// 2. Tambah provider: flutter pub add provider
// 3. Replace isi lib/main.dart dengan code ini
// 4. Run: flutter run
//
// TOPIK:
// - Form registrasi lengkap
// - Semua jenis input widget
// - Real-time validation
// - Provider untuk state management
// - Multi-page (form → list → detail)
//
// INI ADALAH REFERENCE SOLUTION untuk Tugas Praktikum
// =====================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RegistrationProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const RegistrationFormPage(),
        '/list': (_) => const RegistrantListPage(),
        '/detail': (_) => const RegistrantDetailPage(),
      },
    );
  }
}

// ==========================================
// MODEL
// ==========================================
class Registrant {
  final String id;
  final String name;
  final String email;
  final String gender;
  final String programStudi;
  final DateTime dateOfBirth;
  final DateTime registeredAt;

  Registrant({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.programStudi,
    required this.dateOfBirth,
    DateTime? registeredAt,
  }) : registeredAt = registeredAt ?? DateTime.now();

  int get age {
    final now = DateTime.now();
    int a = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) a--;
    return a;
  }

  String get formattedDob {
    const m = ['','Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
    return '${dateOfBirth.day} ${m[dateOfBirth.month]} ${dateOfBirth.year}';
  }
}

// ==========================================
// PROVIDER
// ==========================================
class RegistrationProvider extends ChangeNotifier {
  final List<Registrant> _list = [];

  List<Registrant> get registrants => List.unmodifiable(_list);
  int get count => _list.length;

  void add(Registrant r) { _list.add(r); notifyListeners(); }
  void remove(String id) { _list.removeWhere((r) => r.id == id); notifyListeners(); }
  Registrant? getById(String id) {
    try { return _list.firstWhere((r) => r.id == id); } catch (_) { return null; }
  }
  bool emailExists(String e) => _list.any((r) => r.email.toLowerCase() == e.toLowerCase());
}

// ==========================================
// PAGE 1: REGISTRATION FORM
// ==========================================
class RegistrationFormPage extends StatefulWidget {
  const RegistrationFormPage({super.key});
  @override
  State<RegistrationFormPage> createState() => _RegistrationFormPageState();
}

class _RegistrationFormPageState extends State<RegistrationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();

  bool _obscure = true;
  String _gender = 'Laki-laki';
  String? _prodi;
  DateTime? _dob;
  bool _agree = false;

  final _prodiList = [
    'Teknik Informatika', 'Sistem Informasi',
    'Teknik Komputer', 'Data Science',
  ];

  @override
  void dispose() {
    _nameCtrl.dispose(); _emailCtrl.dispose();
    _passCtrl.dispose(); _dateCtrl.dispose();
    super.dispose();
  }

  String _fmt(DateTime d) {
    const m = ['','Januari','Februari','Maret','April','Mei','Juni',
               'Juli','Agustus','September','Oktober','November','Desember'];
    return '${d.day} ${m[d.month]} ${d.year}';
  }

  Future<void> _pickDate() async {
    final p = await showDatePicker(
      context: context,
      initialDate: DateTime(2004),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (p != null) setState(() { _dob = p; _dateCtrl.text = _fmt(p); });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap setujui syarat & ketentuan'), backgroundColor: Colors.red),
      );
      return;
    }

    final prov = context.read<RegistrationProvider>();
    if (prov.emailExists(_emailCtrl.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email sudah terdaftar!'), backgroundColor: Colors.orange),
      );
      return;
    }

    prov.add(Registrant(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      gender: _gender,
      programStudi: _prodi!,
      dateOfBirth: _dob!,
    ));

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
        title: const Text('Berhasil!'),
        content: Text('${_nameCtrl.text} berhasil didaftarkan.'),
        actions: [
          TextButton(onPressed: () { Navigator.pop(ctx); _reset(); }, child: const Text('Daftar Lagi')),
          ElevatedButton(onPressed: () { Navigator.pop(ctx); Navigator.pushNamed(ctx, '/list'); }, child: const Text('Lihat Daftar')),
        ],
      ),
    );
  }

  void _reset() {
    _formKey.currentState!.reset();
    _nameCtrl.clear(); _emailCtrl.clear();
    _passCtrl.clear(); _dateCtrl.clear();
    setState(() { _gender = 'Laki-laki'; _prodi = null; _dob = null; _agree = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📝 Registrasi Event'),
        actions: [
          Consumer<RegistrationProvider>(
            builder: (_, prov, __) => Badge(
              label: Text('${prov.count}'),
              isLabelVisible: prov.count > 0,
              child: IconButton(
                icon: const Icon(Icons.people),
                onPressed: () => Navigator.pushNamed(context, '/list'),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const Text('📝 Form Pendaftaran', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text('Isi semua field yang bertanda (*)', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),

            // Nama
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Nama Lengkap *', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
              textCapitalization: TextCapitalization.words,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Nama wajib diisi';
                if (v.trim().length < 3) return 'Minimal 3 karakter';
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Email
            TextFormField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: 'Email *', prefixIcon: Icon(Icons.email), border: OutlineInputBorder()),
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Email wajib diisi';
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v.trim())) return 'Format email tidak valid';
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Password
            TextFormField(
              controller: _passCtrl,
              decoration: InputDecoration(
                labelText: 'Password *', prefixIcon: const Icon(Icons.lock), border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
              obscureText: _obscure,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Password wajib diisi';
                if (v.length < 8) return 'Minimal 8 karakter';
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Gender
            const Text('Jenis Kelamin *', style: TextStyle(fontSize: 16)),
            Row(children: [
              Expanded(child: RadioListTile<String>(title: const Text('Laki-laki'), value: 'Laki-laki', groupValue: _gender, onChanged: (v) => setState(() => _gender = v!), contentPadding: EdgeInsets.zero)),
              Expanded(child: RadioListTile<String>(title: const Text('Perempuan'), value: 'Perempuan', groupValue: _gender, onChanged: (v) => setState(() => _gender = v!), contentPadding: EdgeInsets.zero)),
            ]),
            const SizedBox(height: 12),

            // Prodi
            DropdownButtonFormField<String>(
              initialValue: _prodi,
              decoration: const InputDecoration(labelText: 'Program Studi *', prefixIcon: Icon(Icons.school), border: OutlineInputBorder()),
              hint: const Text('Pilih Program Studi'),
              items: _prodiList.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
              onChanged: (v) => setState(() => _prodi = v),
              validator: (v) => v == null ? 'Pilih program studi' : null,
            ),
            const SizedBox(height: 16),

            // Date of Birth
            TextFormField(
              controller: _dateCtrl, readOnly: true,
              decoration: const InputDecoration(labelText: 'Tanggal Lahir *', prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder(), suffixIcon: Icon(Icons.arrow_drop_down)),
              onTap: _pickDate,
              validator: (v) => (v == null || v.isEmpty) ? 'Tanggal lahir wajib diisi' : null,
            ),
            const SizedBox(height: 16),

            // Agree
            CheckboxListTile(
              title: const Text('Saya setuju dengan syarat & ketentuan *'),
              value: _agree,
              onChanged: (v) => setState(() => _agree = v ?? false),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 24),

            // Buttons
            ElevatedButton.icon(onPressed: _submit, icon: const Icon(Icons.app_registration), label: const Text('DAFTAR SEKARANG'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16))),
            const SizedBox(height: 8),
            OutlinedButton(onPressed: _reset, child: const Text('Reset Form')),
          ]),
        ),
      ),
    );
  }
}

// ==========================================
// PAGE 2: REGISTRANT LIST
// ==========================================
class RegistrantListPage extends StatelessWidget {
  const RegistrantListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<RegistrationProvider>(builder: (_, p, __) => Text('Peserta (${p.count})')),
      ),
      body: Consumer<RegistrationProvider>(
        builder: (_, prov, __) {
          if (prov.registrants.isEmpty) {
            return const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.people_outline, size: 80, color: Colors.grey),
              SizedBox(height: 16),
              Text('Belum ada pendaftar', style: TextStyle(fontSize: 18, color: Colors.grey)),
            ]));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: prov.registrants.length,
            itemBuilder: (ctx, i) {
              final r = prov.registrants[i];
              return Card(child: ListTile(
                leading: CircleAvatar(child: Text(r.name[0].toUpperCase())),
                title: Text(r.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${r.programStudi} • ${r.email}'),
                trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () {
                  showDialog(context: ctx, builder: (c) => AlertDialog(
                    title: const Text('Hapus?'),
                    content: Text('Yakin hapus ${r.name}?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(c), child: const Text('Batal')),
                      ElevatedButton(onPressed: () { prov.remove(r.id); Navigator.pop(c); },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text('Hapus')),
                    ],
                  ));
                }),
                onTap: () => Navigator.pushNamed(ctx, '/detail', arguments: r.id),
              ));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => Navigator.pop(context), child: const Icon(Icons.add)),
    );
  }
}

// ==========================================
// PAGE 3: REGISTRANT DETAIL
// ==========================================
class RegistrantDetailPage extends StatelessWidget {
  const RegistrantDetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final r = context.read<RegistrationProvider>().getById(id);
    if (r == null) return Scaffold(appBar: AppBar(title: const Text('Not Found')), body: const Center(child: Text('Tidak ditemukan')));

    return Scaffold(
      appBar: AppBar(title: Text(r.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          CircleAvatar(radius: 50, child: Text(r.name[0].toUpperCase(), style: const TextStyle(fontSize: 36))),
          const SizedBox(height: 16),
          Text(r.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _info(Icons.email, 'Email', r.email),
          _info(Icons.person, 'Gender', r.gender),
          _info(Icons.school, 'Program Studi', r.programStudi),
          _info(Icons.cake, 'Tanggal Lahir', '${r.formattedDob} (${r.age} thn)'),
        ]),
      ),
    );
  }

  Widget _info(IconData icon, String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
