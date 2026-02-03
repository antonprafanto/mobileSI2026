// =============================================================================
// 📱 PERTEMUAN 2 - DEMO 6: HALAMAN PROFIL LENGKAP
// =============================================================================
// Contoh jawaban praktikum: Membuat halaman profil dengan semua kriteria
// CARA MENJALANKAN: Copy ke main.dart dan jalankan flutter run
// =============================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        fontFamily: 'Roboto',
      ),
      home: const ProfilPage(),
    );
  }
}

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        centerTitle: true,
        backgroundColor: colorScheme.inversePrimary,
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // FOTO PROFIL
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: const NetworkImage('https://picsum.photos/200/200'),
                ),
                Positioned(
                  bottom: 0, right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: colorScheme.primary, shape: BoxShape.circle),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // NAMA
            Text('Budi Santoso', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),

            // BIO
            Text('Flutter Developer | Tech Enthusiast', style: TextStyle(color: Colors.grey[600], fontSize: 16)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(color: Colors.green[100], borderRadius: BorderRadius.circular(20)),
              child: const Text('🟢 Online', style: TextStyle(color: Colors.green)),
            ),
            const SizedBox(height: 24),

            // INFO CARDS
            const InfoCard(icon: Icons.email, title: 'Email', value: 'budi@example.com'),
            const SizedBox(height: 12),
            const InfoCard(icon: Icons.phone, title: 'Telepon', value: '+62 812 3456 7890'),
            const SizedBox(height: 12),
            const InfoCard(icon: Icons.location_on, title: 'Alamat', value: 'Jakarta, Indonesia'),
            const SizedBox(height: 12),
            const InfoCard(icon: Icons.language, title: 'Website', value: 'www.budi.dev'),
            const SizedBox(height: 24),

            // BUTTONS
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profil'),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text('Logout', style: TextStyle(color: Colors.red)),
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(16), side: const BorderSide(color: Colors.red)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// Widget InfoCard terpisah (reusable)
class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const InfoCard({super.key, required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.copy, size: 18, color: Colors.grey),
      ),
    );
  }
}

// =============================================================================
// 📝 CATATAN PENTING (UNTUK PEMULA):
// 
// ✅ WIDGET YANG DIGUNAKAN:
// 1. Scaffold - Struktur dasar halaman (AppBar + Body)
// 2. SingleChildScrollView - Membuat konten bisa di-scroll
// 3. Column - Menyusun widget secara vertikal
// 4. Stack + Positioned - Untuk badge kamera di foto profil
// 5. CircleAvatar - Menampilkan foto profil berbentuk lingkaran
// 6. Card + ListTile - Menampilkan informasi dalam kartu
// 7. ElevatedButton & OutlinedButton - Tombol aksi
//
// ✅ KONSEP YANG DITERAPKAN:
// 1. ThemeData - Warna konsisten menggunakan colorScheme
// 2. Reusable Widget - InfoCard bisa dipakai ulang
// 3. Responsive Width - SizedBox(width: double.infinity)
// 4. Padding & SizedBox - Mengatur jarak antar widget
//
// 💡 Tips untuk Mahasiswa:
// - Coba ganti data dengan data pribadi Anda
// - Tambahkan fitur lain seperti statistik follower
// - Eksperimen dengan warna seedColor yang berbeda
// =============================================================================

