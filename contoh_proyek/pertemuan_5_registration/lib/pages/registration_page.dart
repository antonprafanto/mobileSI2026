import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/registration_provider.dart';
import '../widgets/step_indicator.dart';
import '../widgets/custom_text_field.dart';
import 'success_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // Form keys per step
  final _step1FormKey = GlobalKey<FormState>();
  final _step2FormKey = GlobalKey<FormState>();

  // Controllers (dikelola di halaman, bukan provider, untuk performa)
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();

  // Data opsi
  static const List<String> _sessions = [
    'Morning (08.00-12.00)',
    'Afternoon (13.00-17.00)',
    'Evening (18.00-21.00)',
  ];
  static const List<String> _interests = [
    'AI & Machine Learning', 'Mobile Development', 'Web Development',
    'Cloud Computing', 'UI/UX Design', 'DevOps', 'Cybersecurity', 'Blockchain',
  ];
  static const List<String> _cities = [
    'Bandung', 'Jakarta', 'Surabaya', 'Yogyakarta',
    'Semarang', 'Medan', 'Makassar', 'Palembang',
  ];
  static const List<String> _genders = ['Laki-laki', 'Perempuan', 'Tidak disebutkan'];

  AutovalidateMode _autovalidate = AutovalidateMode.disabled;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime d) {
    const months = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
    return '${d.day} ${months[d.month]} ${d.year}';
  }

  Future<void> _nextStep(RegistrationProvider provider) async {
    setState(() => _autovalidate = AutovalidateMode.onUserInteraction);

    if (provider.currentStep == 0) {
      if (!_step1FormKey.currentState!.validate()) return;
      if (provider.data.birthDate == null) {
        _showSnack('Pilih tanggal lahir terlebih dahulu');
        return;
      }
      // Sinkronkan data controller ke provider
      provider.updateName(_nameController.text);
      provider.updateEmail(_emailController.text);
      provider.updatePhone(_phoneController.text);
      provider.nextStep();
    } else if (provider.currentStep == 1) {
      if (!_step2FormKey.currentState!.validate()) return;
      if (provider.data.interests.isEmpty) {
        _showSnack('Pilih setidaknya 1 topik minat');
        return;
      }
      provider.nextStep();
    } else {
      // Submit
      try {
        await provider.submitForm();
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => SuccessPage(data: provider.data),
            ),
          );
        }
      } catch (e) {
        if (mounted) _showSnack('Gagal mendaftar: $e', isError: true);
      }
    }
  }

  void _showSnack(String msg, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationProvider>(builder: (context, provider, _) {
      return Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: const Text('Tech Summit 2026'),
          backgroundColor: const Color(0xFF6C63FF),
          foregroundColor: Colors.white,
          elevation: 0,
          leading: provider.currentStep > 0
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: provider.prevStep,
                )
              : null,
        ),
        body: Column(
          children: [
            // Step indicator
            StepIndicator(
              currentStep: provider.currentStep,
              steps: const ['Info Pribadi', 'Preferensi', 'Konfirmasi'],
            ),

            // Konten
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: provider.currentStep == 0
                      ? _buildStep1(provider, key: const ValueKey(0))
                      : provider.currentStep == 1
                          ? _buildStep2(provider, key: const ValueKey(1))
                          : _buildStep3(provider, key: const ValueKey(2)),
                ),
              ),
            ),

            // Tombol navigasi
            _buildBottomBar(provider),
          ],
        ),
      );
    });
  }

  // ============================================================
  // STEP 1 — Info Pribadi
  // ============================================================
  Widget _buildStep1(RegistrationProvider provider, {Key? key}) {
    return Form(
      key: _step1FormKey,
      autovalidateMode: _autovalidate,
      child: Column(
        key: key,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _pageTitle('Informasi Pribadi', 'Lengkapi data diri Anda'),
          const SizedBox(height: 20),

          CustomTextField(
            controller: _nameController,
            label: 'Nama Lengkap *',
            prefixIcon: Icons.person_outline,
            textCapitalization: TextCapitalization.words,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Nama wajib diisi';
              if (v.trim().length < 3) return 'Minimal 3 karakter';
              return null;
            },
          ),
          const SizedBox(height: 14),

          CustomTextField(
            controller: _emailController,
            label: 'Email *',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Email wajib diisi';
              if (!RegExp(r'^[\w\-.]+@[\w\-]+\.\w{2,}$').hasMatch(v)) {
                return 'Format email tidak valid';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),

          CustomTextField(
            controller: _phoneController,
            label: 'No. HP *',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: (v) {
              if (v == null || v.isEmpty) return 'No. HP wajib diisi';
              if (v.replaceAll(RegExp(r'[\s\-]'), '').length < 10) {
                return 'No. HP tidak valid (min 10 digit)';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),

          // Tanggal Lahir
          CustomTextField(
            controller: _birthDateController,
            label: 'Tanggal Lahir *',
            prefixIcon: Icons.cake_outlined,
            readOnly: true,
            suffixIcon: Icons.calendar_today,
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime(2000),
                firstDate: DateTime(1940),
                lastDate: DateTime.now().subtract(const Duration(days: 365 * 17)),
                helpText: 'Pilih Tanggal Lahir',
              );
              if (picked != null) {
                provider.updateBirthDate(picked);
                _birthDateController.text = _formatDate(picked);
              }
            },
          ),
          if (provider.data.birthDate != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 4),
              child: Text(
                '🎂 Umur: ${provider.data.age} tahun',
                style: TextStyle(color: Colors.indigo.shade700, fontSize: 13),
              ),
            ),

          const SizedBox(height: 14),

          // Jenis Kelamin
          const Text('Jenis Kelamin *', style: TextStyle(fontWeight: FontWeight.w600)),
          ..._genders.map((g) => RadioListTile<String>(
            title: Text(g),
            value: g,
            groupValue: provider.data.gender,
            onChanged: (v) => provider.updateGender(v!),
            contentPadding: EdgeInsets.zero,
            dense: true,
            activeColor: const Color(0xFF6C63FF),
          )),
        ],
      ),
    );
  }

  // ============================================================
  // STEP 2 — Preferensi
  // ============================================================
  Widget _buildStep2(RegistrationProvider provider, {Key? key}) {
    return Form(
      key: _step2FormKey,
      autovalidateMode: _autovalidate,
      child: Column(
        key: key,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _pageTitle('Preferensi Acara', 'Sesuaikan pengalaman Anda'),
          const SizedBox(height: 20),

          // Jenis Tiket
          const Text('Jenis Tiket *', style: TextStyle(fontWeight: FontWeight.w600)),
          ...['Regular (Gratis)', 'VIP (Rp 150.000)', 'VVIP (Rp 350.000)'].map((t) {
            final type = t.split(' ')[0];
            return RadioListTile<String>(
              title: Text(t),
              value: type,
              groupValue: provider.data.ticketType,
              onChanged: (v) => provider.updateTicketType(v!),
              contentPadding: EdgeInsets.zero,
              dense: true,
              activeColor: const Color(0xFF6C63FF),
            );
          }),
          const SizedBox(height: 14),

          // Sesi
          DropdownButtonFormField<String>(
            value: provider.data.session,
            decoration: const InputDecoration(
              labelText: 'Sesi yang Diinginkan *',
              prefixIcon: Icon(Icons.schedule),
            ),
            items: _sessions.map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 13)))).toList(),
            onChanged: (v) => provider.updateSession(v!),
          ),
          const SizedBox(height: 14),

          // Kota
          DropdownButtonFormField<String>(
            value: provider.data.city,
            decoration: const InputDecoration(
              labelText: 'Kota Asal *',
              prefixIcon: Icon(Icons.location_on_outlined),
            ),
            hint: const Text('Pilih kota'),
            items: _cities.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (v) => provider.updateCity(v),
            validator: (v) => v == null ? 'Pilih kota asal' : null,
          ),
          const SizedBox(height: 14),

          // Topik Minat
          const Text('Topik Minat * (pilih minimal 1)', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: _interests.map((i) {
              final selected = provider.data.interests.contains(i);
              return FilterChip(
                label: Text(i, style: const TextStyle(fontSize: 12)),
                selected: selected,
                onSelected: (_) => provider.toggleInterest(i),
                selectedColor: const Color(0xFF6C63FF).withOpacity(0.15),
                checkmarkColor: const Color(0xFF6C63FF),
              );
            }).toList(),
          ),
          const SizedBox(height: 14),

          // Jumlah Tamu
          Text('Jumlah Tamu: ${provider.data.guestCount} orang',
              style: const TextStyle(fontWeight: FontWeight.w600)),
          Slider(
            value: provider.data.guestCount.toDouble(),
            min: 1,
            max: 5,
            divisions: 4,
            label: '${provider.data.guestCount}',
            activeColor: const Color(0xFF6C63FF),
            onChanged: (v) => provider.updateGuestCount(v.round()),
          ),
          const SizedBox(height: 8),

          // Vegetarian
          SwitchListTile(
            title: const Text('Menu Vegetarian'),
            subtitle: const Text('Aktifkan jika membutuhkan menu vegetarian'),
            value: provider.data.vegetarian,
            onChanged: provider.updateVegetarian,
            activeColor: const Color(0xFF6C63FF),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STEP 3 — Konfirmasi
  // ============================================================
  Widget _buildStep3(RegistrationProvider provider, {Key? key}) {
    final data = provider.data;
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _pageTitle('Konfirmasi', 'Periksa kembali data Anda'),
        const SizedBox(height: 20),

        _confirmSection('👤 Informasi Pribadi', [
          ['Nama', data.name],
          ['Email', data.email],
          ['No. HP', data.phone],
          ['Tanggal Lahir', data.formattedBirthDate],
          ['Jenis Kelamin', data.gender],
        ]),
        const SizedBox(height: 12),

        _confirmSection('🎫 Preferensi Acara', [
          ['Tiket', '${data.ticketType} (${data.ticketPrice})'],
          ['Sesi', data.session],
          ['Kota', data.city ?? '-'],
          ['Minat', data.interests.isEmpty ? '-' : data.interests.join(', ')],
          ['Jumlah Tamu', '${data.guestCount} orang'],
          ['Vegetarian', data.vegetarian ? '✅ Ya' : '❌ Tidak'],
        ]),

        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: const Text(
            '⚠️ Dengan menekan "Daftar Sekarang", Anda menyetujui syarat dan ketentuan pendaftaran Tech Summit 2026.',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _confirmSection(String title, List<List<String>> rows) {
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
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const Divider(height: 16),
            ...rows.map((r) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 120, child: Text(r[0], style: const TextStyle(color: Colors.grey, fontSize: 13))),
                  Expanded(child: Text(r[1], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13))),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(RegistrationProvider provider) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, -3))],
      ),
      child: Row(
        children: [
          if (provider.currentStep > 0) ...[
            Expanded(
              child: OutlinedButton(
                onPressed: provider.prevStep,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('← Kembali'),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: provider.isSubmitting ? null : () => _nextStep(provider),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, 50),
                backgroundColor: const Color(0xFF6C63FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: provider.isSubmitting
                  ? const SizedBox(width: 20, height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : Text(
                      provider.isLastStep ? '🎉 Daftar Sekarang' : 'Lanjut →',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(subtitle, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
