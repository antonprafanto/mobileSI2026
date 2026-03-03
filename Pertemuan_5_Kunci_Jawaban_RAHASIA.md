# 🔐 Kunci Jawaban Pertemuan 5 — Form, Validasi & Debugging

> ⚠️ **RAHASIA — HANYA UNTUK INSTRUKTUR**
>
> Jangan dibagikan ke mahasiswa!

---

## Latihan 1: Form Login Sederhana

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: LoginPage(),
));

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login berhasil: ${_emailCtrl.text}\n'
              'Remember me: $_rememberMe'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.lock_person, size: 80, color: Colors.blue),
              const SizedBox(height: 32),

              // Email
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Email wajib diisi';
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                controller: _passCtrl,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
                obscureText: _obscure,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Password wajib diisi';
                  if (v.length < 8) return 'Minimal 8 karakter';
                  if (!v.contains(RegExp(r'[A-Z]'))) return 'Harus ada huruf besar';
                  if (!v.contains(RegExp(r'[0-9]'))) return 'Harus ada angka';
                  return null;
                },
              ),
              const SizedBox(height: 8),

              // Remember Me
              CheckboxListTile(
                title: const Text('Ingat Saya'),
                value: _rememberMe,
                onChanged: (v) => setState(() => _rememberMe = v ?? false),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 16),

              // Login Button
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('LOGIN', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {/* Navigate to register */},
                child: const Text('Belum punya akun? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## Latihan 2: Form Survey

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: SurveyPage(),
));

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});
  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _saranCtrl = TextEditingController();

  String _gender = 'Laki-laki';
  String? _semester;
  double _satisfaction = 5;

  // Checkbox multiple
  Map<String, bool> _interests = {
    'Mobile': false,
    'Web': false,
    'AI': false,
    'Database': false,
  };

  bool _submitted = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _saranCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() => _submitted = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Survey berhasil disubmit!'), backgroundColor: Colors.green),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Survey Mahasiswa')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Nama
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nama *', border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),

              // Gender (Radio)
              const Text('Jenis Kelamin:', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(children: [
                Expanded(child: RadioListTile<String>(
                  title: const Text('L'), value: 'Laki-laki',
                  groupValue: _gender, onChanged: (v) => setState(() => _gender = v!),
                )),
                Expanded(child: RadioListTile<String>(
                  title: const Text('P'), value: 'Perempuan',
                  groupValue: _gender, onChanged: (v) => setState(() => _gender = v!),
                )),
              ]),

              // Semester (Dropdown)
              DropdownButtonFormField<String>(
                value: _semester,
                decoration: const InputDecoration(
                  labelText: 'Semester *', border: OutlineInputBorder(),
                ),
                items: List.generate(8, (i) => '${i + 1}')
                    .map((s) => DropdownMenuItem(value: s, child: Text('Semester $s')))
                    .toList(),
                onChanged: (v) => setState(() => _semester = v),
                validator: (v) => v == null ? 'Pilih semester' : null,
              ),
              const SizedBox(height: 16),

              // Kepuasan (Slider)
              Text('Tingkat Kepuasan: ${_satisfaction.round()}/10',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Slider(
                value: _satisfaction, min: 0, max: 10, divisions: 10,
                label: '${_satisfaction.round()}',
                onChanged: (v) => setState(() => _satisfaction = v),
              ),

              // Bidang Minat (Checkbox multiple)
              const Text('Bidang Minat:', style: TextStyle(fontWeight: FontWeight.bold)),
              ..._interests.entries.map((e) => CheckboxListTile(
                title: Text(e.key),
                value: e.value,
                onChanged: (v) => setState(() => _interests[e.key] = v ?? false),
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
              )),
              const SizedBox(height: 8),

              // Saran (multiline)
              TextFormField(
                controller: _saranCtrl,
                decoration: const InputDecoration(
                  labelText: 'Saran', border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                maxLength: 500,
              ),
              const SizedBox(height: 16),

              ElevatedButton(onPressed: _submit, child: const Text('SUBMIT')),

              // Summary
              if (_submitted) ...[
                const Divider(height: 32),
                const Text('📊 Hasil Survey:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Card(child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nama: ${_nameCtrl.text}'),
                      Text('Gender: $_gender'),
                      Text('Semester: $_semester'),
                      Text('Kepuasan: ${_satisfaction.round()}/10'),
                      Text('Minat: ${_interests.entries.where((e) => e.value).map((e) => e.key).join(", ")}'),
                      Text('Saran: ${_saranCtrl.text.isEmpty ? "-" : _saranCtrl.text}'),
                    ],
                  ),
                )),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## Latihan 3: Form Multi-Step (Bonus)

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: MultiStepFormPage(),
));

class MultiStepFormPage extends StatefulWidget {
  const MultiStepFormPage({super.key});
  @override
  State<MultiStepFormPage> createState() => _MultiStepFormPageState();
}

class _MultiStepFormPageState extends State<MultiStepFormPage> {
  int _currentStep = 0;

  // Step 1 controllers
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  // Step 2
  String? _prodi;
  String? _semester;
  final _ipkCtrl = TextEditingController();

  // Form keys per step
  final _step1Key = GlobalKey<FormState>();
  final _step2Key = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _ipkCtrl.dispose();
    super.dispose();
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0: return _step1Key.currentState?.validate() ?? false;
      case 1: return _step2Key.currentState?.validate() ?? false;
      default: return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Multi-Step')),
      body: Stepper(
        currentStep: _currentStep,
        type: StepperType.vertical,
        onStepContinue: () {
          if (_currentStep < 2) {
            if (_validateCurrentStep()) {
              setState(() => _currentStep++);
            }
          } else {
            // Submit final
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('✅ Form submitted!'), backgroundColor: Colors.green),
            );
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) setState(() => _currentStep--);
        },
        onStepTapped: (step) {
          if (step < _currentStep) setState(() => _currentStep = step);
        },
        steps: [
          // STEP 1: Data Diri
          Step(
            title: const Text('Data Diri'),
            subtitle: _currentStep > 0 ? Text(_nameCtrl.text) : null,
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            content: Form(
              key: _step1Key,
              child: Column(children: [
                TextFormField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(labelText: 'Nama *', border: OutlineInputBorder()),
                  validator: (v) => (v == null || v.isEmpty) ? 'Wajib' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(labelText: 'Email *', border: OutlineInputBorder()),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Wajib';
                    if (!v.contains('@')) return 'Email tidak valid';
                    return null;
                  },
                ),
              ]),
            ),
          ),

          // STEP 2: Akademik
          Step(
            title: const Text('Akademik'),
            subtitle: _currentStep > 1 ? Text('$_prodi, Smt $_semester') : null,
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            content: Form(
              key: _step2Key,
              child: Column(children: [
                DropdownButtonFormField<String>(
                  value: _prodi,
                  decoration: const InputDecoration(labelText: 'Program Studi *', border: OutlineInputBorder()),
                  items: ['Teknik Informatika', 'Sistem Informasi', 'Data Science']
                      .map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                  onChanged: (v) => setState(() => _prodi = v),
                  validator: (v) => v == null ? 'Pilih prodi' : null,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _semester,
                  decoration: const InputDecoration(labelText: 'Semester *', border: OutlineInputBorder()),
                  items: List.generate(8, (i) => '${i + 1}')
                      .map((s) => DropdownMenuItem(value: s, child: Text('Semester $s'))).toList(),
                  onChanged: (v) => setState(() => _semester = v),
                  validator: (v) => v == null ? 'Pilih semester' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _ipkCtrl,
                  decoration: const InputDecoration(labelText: 'IPK', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v != null && v.isNotEmpty) {
                      final ipk = double.tryParse(v);
                      if (ipk == null || ipk < 0 || ipk > 4) return 'IPK 0.0 - 4.0';
                    }
                    return null;
                  },
                ),
              ]),
            ),
          ),

          // STEP 3: Review
          Step(
            title: const Text('Review & Submit'),
            isActive: _currentStep >= 2,
            content: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('📋 Review Data:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const Divider(),
                    Text('Nama: ${_nameCtrl.text}'),
                    Text('Email: ${_emailCtrl.text}'),
                    Text('Program Studi: ${_prodi ?? "-"}'),
                    Text('Semester: ${_semester ?? "-"}'),
                    Text('IPK: ${_ipkCtrl.text.isEmpty ? "-" : _ipkCtrl.text}'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## Praktikum: Form Pendaftaran Event

> Reference solution ada di `contoh_kode/pertemuan_5/05_registration_form_complete.dart`
> dan project lengkap di `contoh_proyek/pertemuan_5_registration/`

### Poin Penilaian

| Kriteria                         | Poin | Cek                                                                                           |
| -------------------------------- | ---- | --------------------------------------------------------------------------------------------- |
| Min 5 field berbeda jenis        | 25   | nama, email, password, gender(radio), prodi(dropdown), dob(datepicker), agree(checkbox) = 7 ✓ |
| Validasi real-time               | 25   | autovalidateMode.onUserInteraction ✓                                                          |
| Min 2 input selain TextFormField | —    | Radio + Dropdown + DatePicker + Checkbox = 4 ✓                                                |
| Provider untuk state             | 20   | RegistrationProvider extends ChangeNotifier ✓                                                 |
| Halaman list pendaftar           | —    | RegistrantListPage ✓                                                                          |
| Error handling try-catch         | 15   | Di getById() dan parsing ✓                                                                    |
| Reset form setelah submit        | —    | \_resetForm() ✓                                                                               |
| Code quality                     | 15   | Dispose, naming, structure ✓                                                                  |

### Common Issues & Grading Notes

- **-5** jika lupa dispose controllers
- **-5** jika pakai TextField bukan TextFormField
- **-3** jika tidak ada `autovalidateMode`
- **-3** jika dropdown initial value error
- **-2** jika DatePicker tidak handle null (cancel)
- **Bonus +10** jika pakai Stepper multi-step
- **Bonus +5** jika ada edit functionality
- **Bonus +5** jika ada search/filter
