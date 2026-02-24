/// Model data untuk pendaftar event
class RegistrantModel {
  // Step 1: Informasi Pribadi
  String name;
  String email;
  String phone;
  DateTime? birthDate;
  String gender;

  // Step 2: Preferensi Acara
  String ticketType;
  String session;
  List<String> interests;
  bool vegetarian;
  int guestCount;
  String? city;
  String? specialRequest;

  RegistrantModel({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.birthDate,
    this.gender = 'Tidak disebutkan',
    this.ticketType = 'Regular',
    this.session = 'Morning (08.00-12.00)',
    List<String>? interests,
    this.vegetarian = false,
    this.guestCount = 1,
    this.city,
    this.specialRequest,
  }) : interests = interests ?? [];

  // Hitung umur dari tanggal lahir
  int? get age {
    if (birthDate == null) return null;
    final today = DateTime.now();
    int age = today.year - birthDate!.year;
    if (today.month < birthDate!.month ||
        (today.month == birthDate!.month && today.day < birthDate!.day)) {
      age--;
    }
    return age;
  }

  // Format tanggal lahir ke teks
  String get formattedBirthDate {
    if (birthDate == null) return '-';
    const months = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return '${birthDate!.day} ${months[birthDate!.month]} ${birthDate!.year}';
  }

  // Harga tiket berdasarkan jenis
  String get ticketPrice {
    switch (ticketType) {
      case 'VIP':
        return 'Rp 150.000';
      case 'VVIP':
        return 'Rp 350.000';
      default:
        return 'Gratis';
    }
  }

  // Salin dengan nilai baru (immutable-style update)
  RegistrantModel copyWith({
    String? name,
    String? email,
    String? phone,
    DateTime? birthDate,
    String? gender,
    String? ticketType,
    String? session,
    List<String>? interests,
    bool? vegetarian,
    int? guestCount,
    String? city,
    String? specialRequest,
  }) {
    return RegistrantModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      ticketType: ticketType ?? this.ticketType,
      session: session ?? this.session,
      interests: interests ?? List.from(this.interests),
      vegetarian: vegetarian ?? this.vegetarian,
      guestCount: guestCount ?? this.guestCount,
      city: city ?? this.city,
      specialRequest: specialRequest ?? this.specialRequest,
    );
  }
}
