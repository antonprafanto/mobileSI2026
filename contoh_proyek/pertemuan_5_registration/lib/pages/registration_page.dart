import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/registrant_model.dart';
import '../providers/registration_provider.dart';
import '../widgets/custom_text_field.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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
    'Teknik Informatika',
    'Sistem Informasi',
    'Teknik Komputer',
    'Data Science',
    'Desain Komunikasi Visual',
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _dateCtrl.dispose();
    super.dispose();
  }

  String _formatDate(DateTime d) {
    const m = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    return '${d.day} ${m[d.month]} ${d.year}';
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2004, 1, 1),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      helpText: 'Pilih Tanggal Lahir',
    );
    if (picked != null) {
      setState(() {
        _dob = picked;
        _dateCtrl.text = _formatDate(picked);
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap setujui syarat & ketentuan'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final provider = context.read<RegistrationProvider>();
    if (provider.isEmailRegistered(_emailCtrl.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email sudah terdaftar!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final registrant = Registrant(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      gender: _gender,
      programStudi: _prodi!,
      dateOfBirth: _dob!,
    );

    provider.addRegistrant(registrant);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
        title: const Text('Registrasi Berhasil!'),
        content: Text('${registrant.name} berhasil didaftarkan.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _reset();
            },
            child: const Text('Daftar Lagi'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushNamed(context, '/list');
            },
            child: const Text('Lihat Daftar'),
          ),
        ],
      ),
    );
  }

  void _reset() {
    _formKey.currentState!.reset();
    _nameCtrl.clear();
    _emailCtrl.clear();
    _passCtrl.clear();
    _dateCtrl.clear();
    setState(() {
      _gender = 'Laki-laki';
      _prodi = null;
      _dob = null;
      _agree = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi Event'),
        actions: [
          Consumer<RegistrationProvider>(
            builder: (context, prov, _) => Badge(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '📝 Form Pendaftaran',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Isi semua field yang bertanda (*)',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // Nama
              CustomTextField(
                controller: _nameCtrl,
                label: 'Nama Lengkap *',
                prefixIcon: Icons.person,
                textCapitalization: TextCapitalization.words,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Nama wajib diisi';
                  if (v.trim().length < 3) return 'Minimal 3 karakter';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email
              CustomTextField(
                controller: _emailCtrl,
                label: 'Email *',
                hint: 'nama@email.com',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Email wajib diisi';
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v.trim())) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Password
              CustomTextField(
                controller: _passCtrl,
                label: 'Password *',
                prefixIcon: Icons.lock,
                obscureText: _obscure,
                suffixIcon: IconButton(
                  icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Password wajib diisi';
                  if (v.length < 8) return 'Minimal 8 karakter';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Gender
              const Text('Jenis Kelamin *', style: TextStyle(fontSize: 16)),
              RadioGroup<String>(
                groupValue: _gender,
                onChanged: (v) => setState(() => _gender = v!),
                child: Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Laki-laki'),
                        value: 'Laki-laki',
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Perempuan'),
                        value: 'Perempuan',
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Program Studi
              DropdownButtonFormField<String>(
                value: _prodi,
                decoration: const InputDecoration(
                  labelText: 'Program Studi *',
                  prefixIcon: Icon(Icons.school),
                  border: OutlineInputBorder(),
                ),
                hint: const Text('Pilih Program Studi'),
                items: _prodiList
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (v) => setState(() => _prodi = v),
                validator: (v) => v == null ? 'Pilih program studi' : null,
              ),

              const SizedBox(height: 16),

              // Date of Birth
              CustomTextField(
                controller: _dateCtrl,
                label: 'Tanggal Lahir *',
                prefixIcon: Icons.calendar_today,
                readOnly: true,
                suffixIcon: const Icon(Icons.arrow_drop_down),
                onTap: _pickDate,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Tanggal lahir wajib diisi' : null,
              ),
              const SizedBox(height: 16),

              // Agree
              CheckboxListTile(
                title: const Text('Saya setuju dengan syarat & ketentuan *'),
                subtitle: const Text('Wajib dicentang'),
                value: _agree,
                onChanged: (v) => setState(() => _agree = v ?? false),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 24),

              // Buttons
              ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.app_registration),
                label: const Text('DAFTAR SEKARANG'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: _reset,
                child: const Text('Reset Form'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
