# -*- coding: utf-8 -*-
"""Append Part 2 & Part 3 to Pertemuan 4"""

part2_part3_content = """
## 🔗 PART 2: setState dan Keterbatasannya (20 menit)

### The Prop Drilling Problem

Saat app tumbuh besar, setState punya masalah serius: **Prop Drilling**.

**💡 ANALOGI - Telepon Beranting**:
```
Boss → Manager → Supervisor → Team Lead → Worker

Boss bilang: "Increase salary"
Harus lewat 4 orang! 
Kalau Manager lupa pass? FAIL!
```

### ✏️ CODING BERSAMA: Prop Drilling Hell Demo (15 menit)

Mari buat app yang show masalah prop drilling!

**Step 1: Create HomePage with counter** (3 menit)

```dart
// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _increment() {
    setState(() => _counter++);
  }

  void _reset() {
    setState(() => _counter = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          // Badge showing counter
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$_counter',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter: $_counter',
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _increment,
              child: const Text('Increment'),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      counter: _counter,      // ← Pass counter
                      onReset: _reset,        // ← Pass callback
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.person),
              label: const Text('Go to Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Step 2: Create ProfilePage (needs counter from HomePage)** (4 menit)

```dart
// lib/pages/profile_page.dart
import 'package:flutter/material.dart';
import 'settings_page.dart';

class ProfilePage extends StatelessWidget {
  final int counter;           // ← Receive from HomePage
  final VoidCallback onReset;  // ← Receive callback

  const ProfilePage({
    super.key,
    required this.counter,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 20),
            const Text(
              'User Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Points: $counter', // ← Use counter here!
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(
                      counter: counter,    // ← Pass again!
                      onReset: onReset,    // ← Pass again!
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.settings),
              label: const Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Step 3: Create SettingsPage (needs reset from HomePage!)** (5 menit)

```dart
// lib/pages/settings_page.dart
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final int counter;           // ← Receive from Profile (from Home!)
  final VoidCallback onReset;  // ← Receive from Profile (from Home!)

  const SettingsPage({
    super.key,
    required this.counter,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.settings, size: 80),
            const SizedBox(height: 20),
            Text(
              'Current Points: $counter',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                onReset(); // ← Call callback 2 levels deep!
                Navigator.pop(context);
                Navigator.pop(context); // Back to home
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reset Points'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '⚠️ This is 2 levels deep from HomePage!',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Hot Reload & Test!**

Flow: Home → Profile → Settings → Reset → Back to Home

**LIHATLAH MASALAHNYA:**

```
HomePage (has _counter, _reset)
   │
   ├─ Pass counter + onReset
   ↓
ProfilePage (doesn't use onReset, just pass it!)
   │
   ├─ Pass counter + onReset AGAIN
   ↓
SettingsPage (finally uses onReset!)
```

**📊 Visualisasi Prop Drilling**:

```
┌────────────────────────────────┐
│ HomePage                       │
│ _counter: 5                    │
│ _increment(), _reset()         │
└────────────┬───────────────────┘
             │ Pass counter + onReset
             ↓
┌────────────────────────────────┐
│ ProfilePage                    │
│ Just displays counter          │
│ Doesn't use onReset!           │ ← WASTE!
└────────────┬───────────────────┘
             │ Pass counter + onReset AGAIN
             ↓
┌────────────────────────────────┐
│ SettingsPage                   │
│ Finally uses onReset()         │
└────────────────────────────────┘

Problem: ProfilePage is just a "courier"!
```

### 🎯 EKSPERIMEN 3: Count Rebuilds (3 menit)

Add print statements to see rebuilds:

```dart
// In HomePage build():
@override
Widget build(BuildContext context) {
  print('🔴 HomePage rebuilt!');
  return Scaffold(...);
}

// In ProfilePage build():
@override
Widget build(BuildContext context) {
  print('🟡 ProfilePage rebuilt!');
  return Scaffold(...);
}

// In SettingsPage build():
@override
Widget build(BuildContext context) {
  print('🟢 SettingsPage rebuilt!');
  return Scaffold(...);
}
```

**Test**: Increment di HomePage → Check console

Result:
```
🔴 HomePage rebuilt!
```

Only HomePage rebuilds! ✓ Good.

**But imagine**:
- 10 pages need counter
- 5 pages need reset function
- Constructor parameters = NIGHTMARE 😱

> ⚠️ **TROUBLESHOOTING - setState Limitations**:
>
> **Problem**: "Too many constructor parameters"
> - **Cause**: Passing state through multiple levels
> - **Impact**: Code hard to read, maintain, test
> - **Sign**: Widget has >3 parameters just for passing data
>
> **Problem**: "Widget doesn't use data but needs to pass it"
> - **Cause**: Prop drilling (middle widget just courier)
> - **Impact**: Tight coupling, hard to refactor
> - **Example**: ProfilePage doesn't use onReset but must pass it
>
> **Problem**: "Duplicate state in multiple widgets"
> - **Cause**: Each widget has own copy of state
> - **Impact**: State out of sync, bugs
> - **Sign**: Same data stored in 2+ places

### 💡 Tips & Best Practices - When setState Fails

**setState FAILS when:**
- ❌ State needed in >2 widgets
- ❌ Widgets tidak direct parent-child
- ❌ Deep nesting (3+ levels)
- ❌ State complex (cart, user profile)

**SIGNS you need better state management:**
- 🚩 Constructor has >5 parameters
- 🚩 Passing callbacks 3+ levels deep
- 🚩 Widget just "passes through" data
- 🚩 Duplicate setState in multiple widgets
- 🚩 Hard to test because of coupling

**SOLUTION**: Provider! 🎉

---

## 📦 PART 3: Introduction to Provider (10 menit)

### What is Provider?

**Provider** adalah state management solution **officially recommended** oleh Flutter team.

**💡 ANALOGI - Provider seperti WiFi Router**:

```
❌ WITHOUT Provider (Cables):      ✅ WITH Provider (WiFi):
┌────────┐                        ┌─────────────┐
│ Phone  ├──cable──┐              │   Router    │
└────────┘          │              │ (Provider)  │
┌────────┐          │              └──────┬──────┘
│ Laptop ├──cable──┤                 📡   │   📡
└────────┘          │              ┌──────┴──────┐
┌────────┐          │              ↓             ↓
│ Tablet ├──cable──┘          Phone          Laptop
└────────┘                    (Consumer)     (Consumer)

Many cables!                  Wireless access!
Hard to add device!          Easy to add new listener!
```

### Why Provider?

| Feature | setState | Provider |
|---------|----------|----------|
| **Scope** | Local (1 widget) | App-wide |
| **Sharing** | Via parameters | Direct access |
| **Rebuilds** | Entire widget | Only listeners |
| **Testing** | Hard (coupled) | Easy (injectable) |
| **Code** | Prop drilling | Clean |
| **Official** | ✓ Built-in | ✓ Recommended |

### Provider Benefits

1. ✅ **No Prop Drilling** - Access state from anywhere
2. ✅ **Efficient Rebuilds** - Only listeners rebuild
3. ✅ **Separation of Concerns** - Business logic separate from UI
4. ✅ **Testable** - Easy to mock and test
5. ✅ **Official** - Recommended by Flutter team
6. ✅ **Built on InheritedWidget** - Fast and reliable

### 📦 Installation (3 menit)

**Step 1**: Add dependency ke `pubspec.yaml`

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.0  # ← ADD THIS LINE
```

**Step 2**: Install package

Terminal/Command Prompt:
```bash
flutter pub get
```

Atau shortcut:
```bash
flutter pub add provider
```

**Step 3**: Verify installation

Cek `pubspec.lock` → should see `provider: 6.1.0` (or latest)

**Step 4**: Import in code

```dart
import 'package:provider/provider.dart';
```

Done! 🎉

### How Provider Works

**Konsep dasar**:

```
1. CREATE model class (holds state)
   ↓
2. PROVIDE at app level (make available)
   ↓
3. CONSUME anywhere (listen to changes)
   ↓
4. UPDATE state → Notify listeners
   ↓
5. UI rebuilds automatically!
```

**Visualisasi**:

```
Provider<CounterModel>
       ↓
  MaterialApp
       │
┌──────┼──────┐
│      │      │
Home  Profile Settings
│      │      │
└──────┴──────┘
    All can access CounterModel!
    No passing parameters!
```

### Provider vs Other Solutions

| Solution | Complexity | Learning Curve | Use Case |
|----------|-----------|----------------|----------|
| **setState** | ⭐ | Easy | Local state |
| **Provider** | ⭐⭐ | Medium | App state |
| **Riverpod** | ⭐⭐⭐ | Hard | Large apps |
| **Bloc** | ⭐⭐⭐⭐ | Very Hard | Enterprise |
| **GetX** | ⭐⭐ | Medium | All-in-one |

**Recommendation**: Start dengan Provider! Official + Cukup powerful + Not too complex.

### Next: ChangeNotifier Pattern

Di Part 4, kita akan belajar **ChangeNotifier** - core pattern di Provider!

**Sneak peek**:

```dart
class CounterModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
  
  void increment() {
    _count++;
    notifyListeners(); // ← Magic happens here!
  }
}
```

Simple kan? Let's go! 🚀

---
"""

# Append to existing file
with open('Pertemuan_4_State_Management_dengan_Provider.md', 'a', encoding='utf-8') as f:
    f.write(part2_part3_content)

print("✅ Part 2 & Part 3 appended successfully!")
print("Total new lines:", len(part2_part3_content.split('\n')))
print("\n📊 Added content:")
print("- 🔗 Part 2: setState Limitations")
print("- ✏️ Prop Drilling Hell demo (3-page flow)")
print("- 🎯 Experiment 3 (Count rebuilds)")
print("- 📊 ASCII diagrams (Prop drilling visualization)")
print("- ⚠️ Troubleshooting (setState limitations)")
print("- 💡 Tips (When setState fails)")
print("- 📦 Part 3: Provider Introduction")
print("- 💡 Analogy (WiFi Router)")
print("- 📦 Installation guide")
print("- 📊 Comparison tables")
