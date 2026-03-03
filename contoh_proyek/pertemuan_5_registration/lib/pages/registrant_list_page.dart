import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/registration_provider.dart';

class RegistrantListPage extends StatelessWidget {
  const RegistrantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<RegistrationProvider>(
          builder: (_, prov, __) => Text('Daftar Peserta (${prov.count})'),
        ),
      ),
      body: Consumer<RegistrationProvider>(
        builder: (context, prov, _) {
          if (prov.registrants.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Belum ada pendaftar',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Daftar sekarang di halaman registrasi!',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: prov.registrants.length,
            itemBuilder: (ctx, i) {
              final r = prov.registrants[i];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(r.name[0].toUpperCase()),
                  ),
                  title: Text(
                    r.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${r.programStudi} • ${r.email}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: ctx,
                        builder: (c) => AlertDialog(
                          title: const Text('Hapus Pendaftar?'),
                          content: Text('Yakin hapus ${r.name}?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(c),
                              child: const Text('Batal'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                prov.removeRegistrant(r.id);
                                Navigator.pop(c);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('Hapus'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(ctx, '/detail', arguments: r.id);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
