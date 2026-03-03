import 'package:flutter/material.dart';
import '../models/registrant_model.dart';

class SummaryCard extends StatelessWidget {
  final Registrant registrant;

  const SummaryCard({super.key, required this.registrant});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📋 Ringkasan Pendaftaran',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildRow(Icons.person, 'Nama', registrant.name),
            _buildRow(Icons.email, 'Email', registrant.email),
            _buildRow(Icons.person_outline, 'Gender', registrant.gender),
            _buildRow(Icons.school, 'Program Studi', registrant.programStudi),
            _buildRow(
              Icons.cake,
              'Tanggal Lahir',
              '${registrant.formattedDateOfBirth} (${registrant.age} tahun)',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 12),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
