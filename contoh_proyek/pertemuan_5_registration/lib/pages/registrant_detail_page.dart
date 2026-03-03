import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/registration_provider.dart';
import '../widgets/summary_card.dart';

class RegistrantDetailPage extends StatelessWidget {
  const RegistrantDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final registrant = context.read<RegistrationProvider>().getById(id);

    if (registrant == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Not Found')),
        body: const Center(child: Text('Pendaftar tidak ditemukan')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(registrant.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              child: Text(
                registrant.name[0].toUpperCase(),
                style: const TextStyle(fontSize: 36),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              registrant.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Terdaftar: ${registrant.formattedRegisteredAt}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            SummaryCard(registrant: registrant),
          ],
        ),
      ),
    );
  }
}
