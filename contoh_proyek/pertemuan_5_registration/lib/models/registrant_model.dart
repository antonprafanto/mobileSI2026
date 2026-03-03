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
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      a--;
    }
    return a;
  }

  String get formattedDateOfBirth {
    const months = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    return '${dateOfBirth.day} ${months[dateOfBirth.month]} ${dateOfBirth.year}';
  }

  String get formattedRegisteredAt {
    return '${registeredAt.day}/${registeredAt.month}/${registeredAt.year} '
        '${registeredAt.hour.toString().padLeft(2, '0')}:'
        '${registeredAt.minute.toString().padLeft(2, '0')}';
  }
}
