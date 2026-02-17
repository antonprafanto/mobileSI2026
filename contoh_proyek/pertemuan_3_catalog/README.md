# Pertemuan 3 - Catalog App Demo

Full Flutter project demonstrating **ListView**, **GridView**, and **Navigation** concepts.

## 🎯 Features

- ✅ Product catalog with GridView
- ✅ Category filtering
- ✅ Product detail page with data passing
- ✅ ListView demos (builder, separated, basic)
- ✅ GridView demos (count, builder, extent)
- ✅ Navigation examples (push, pop, named routes)
- ✅ Data return from pages
- ✅ Drawer navigation

## 📂 Project Structure

```
lib/
├── main.dart                    # App entry with named routes
├── models/
│   └── product.dart             # Product model
├── data/
│   └── products_data.dart       # Sample product data
├── pages/
│   ├── home_page.dart           # Main catalog (GridView)
│   ├── product_detail_page.dart # Product details
│   ├── category_page.dart       # Category view
│   ├── list_demos_page.dart     # ListView examples
│   ├── grid_demos_page.dart     # GridView examples
│   ├── navigation_demo_page.dart # Navigation examples
│   └── data_passing_demo_page.dart # Data passing examples
└── widgets/
    ├── product_card.dart        # Reusable product card
    └── app_drawer.dart          # Navigation drawer
```

## 🚀 How to Run

1. Navigate to project directory:
   ```bash
   cd contoh_proyek/pertemuan_3_catalog
   ```

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## 📖 What You'll Learn

### ListView Concepts
- `ListView.builder` - Efficient list rendering
- `ListView.separated` - Lists with dividers
- Basic `ListView` - Static lists

### GridView Concepts
- `GridView.count` - Fixed column count
- `GridView.builder` - Efficient grid rendering
- `GridView.extent` - Fixed item width

### Navigation Concepts
- `Navigator.push` - Navigate to new page
- `Navigator.pop` - Go back
- `Navigator.pushNamed` - Named routes
- Passing data between pages
- Receiving return values

## 🎓 Learning Path

1. **Start**: Open drawer → "Home" (see GridView catalog)
2. **Categories**: Filter products by category
3. **Product Detail**: Tap any product (data passing demo)
4. **ListView Demos**: See different ListView patterns
5. **GridView Demos**: See different GridView patterns
6. **Navigation Demo**: Try push/pop and return values
7. **Data Passing Demo**: See how to pass data to pages

## 💡 Key Code Patterns

### GridView with 2 columns:
``` dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.7,
  ),
  itemBuilder: (context, index) => ProductCard(...),
)
```

### Navigation with data:
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailPage(product: product),
  ),
);
```

### Return data:
```dart
final result = await Navigator.push(...);
if (result != null) {
  // Use returned data
}
```

## 📝 Related Material

See [Pertemuan_3_ListView_GridView_dan_Navigasi.md](../../Pertemuan_3_ListView_GridView_dan_Navigasi.md) for complete learning material.

---

**Created for**: Mobile Programming Course  
**Topic**: Pertemuan 3 - ListView, GridView, Navigation
