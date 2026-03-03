# Pertemuan 5 - Registration Form with Provider

Full Flutter project demonstrating **Form, Validasi & Debugging**.

## 🎯 Features

- ✅ Registration form with real-time validation
- ✅ Multiple input types: TextFormField, Radio, Dropdown, DatePicker, Checkbox
- ✅ Provider for state management (registrant list)
- ✅ Registrant list page with delete functionality
- ✅ Registrant detail page with summary card
- ✅ Reusable widgets (CustomTextField, StepIndicator, SummaryCard)
- ✅ Error handling & email duplicate check

## 📂 Project Structure

```
lib/
├── main.dart                        # App with Provider setup
├── models/
│   └── registrant_model.dart        # Registrant data model
├── providers/
│   └── registration_provider.dart   # ChangeNotifier for registrants
├── pages/
│   ├── registration_page.dart       # Main registration form
│   ├── registrant_list_page.dart    # List of registrants
│   └── registrant_detail_page.dart  # Registrant detail view
└── widgets/
    ├── custom_text_field.dart       # Reusable text field
    ├── step_indicator.dart          # Step indicator for multi-step
    └── summary_card.dart            # Summary display card
```

## 🚀 How to Run

```bash
cd contoh_proyek/pertemuan_5_registration
flutter pub get
flutter run
```

## 📖 What You'll Learn

- ✅ Form widget with GlobalKey
- ✅ TextFormField validation (real-time + on-submit)
- ✅ Various input widgets (Radio, Dropdown, DatePicker, Checkbox)
- ✅ Provider for managing form data across pages
- ✅ Reusable widget patterns
- ✅ Error handling

## 🎓 Learning Path

1. **Registration Page**: Fill form with validation
2. **Submit**: See success dialog
3. **List Page**: View all registrants
4. **Detail Page**: See full registrant info
5. **Delete**: Remove registrants

## 📝 Related Material

See [Pertemuan_5_Form_Validasi_dan_Debugging.md](../../Pertemuan_5_Form_Validasi_dan_Debugging.md)

---

**Dependencies**: provider ^6.1.0
**Topic**: Pertemuan 5 - Form, Validasi & Debugging
