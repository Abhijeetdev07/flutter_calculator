# 🧮 Calculator App

An Apple-style calculator built with Flutter featuring a sleek dark theme and a fun Easter egg!

## ✨ Features

### Design
- 🎨 **Apple iOS Calculator Design** - Clean, modern interface with dark theme
- 🔘 **Circular Buttons** - Smooth, rounded button design
- 🟠 **Color-Coded Buttons**
  - Orange: Operators (÷, ×, -, +, =)
  - Light Gray: Functions (AC, +/-, %)
  - Dark Gray: Numbers (0-9, .)
- 📱 **Responsive Layout** - Works on all screen sizes

### Functionality
- ➕ **Basic Operations**: Addition, Subtraction, Multiplication, Division
- 💯 **Percentage Calculation**
- ➕➖ **Positive/Negative Toggle**
- 🔄 **All Clear (AC)** - Reset calculator
- 🔢 **Decimal Support** - Handle decimal numbers
- 🎭 **Easter Egg**: Type `8 + =` to see "Abhijeet"!

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.9.2 or higher)
- Android Studio / VS Code
- Android Emulator or Physical Device

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd signup_form
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build APK

To create a release APK:
```bash
flutter build apk --release
```

The APK will be located at:
```
build/app/outputs/flutter-apk/app-release.apk
```

## 📱 Installation on Android

1. Copy `app-release.apk` to your Android device
2. Enable "Install from Unknown Sources" in Settings
3. Tap the APK file to install
4. Open the "Calculator" app

## 🎨 Customization

### Change App Name
Edit `android/app/src/main/AndroidManifest.xml`:
```xml
<application android:label="Your App Name">
```

### Change App Icon
Replace icon files in:
```
android/app/src/main/res/mipmap-*/ic_launcher.png
```

## 🎯 Easter Egg

Try this sequence:
1. Press `8`
2. Press `+`
3. Press `=`
4. Watch the magic! ✨

## 🛠️ Built With

- **Flutter** - UI Framework
- **Dart** - Programming Language
- **Material Design 3** - Design System

## 📝 Project Structure

```
lib/
  └── main.dart          # Main calculator logic and UI
android/
  └── app/
      └── src/main/
          ├── AndroidManifest.xml    # App configuration
          └── res/
              └── mipmap-*/          # App icons
```

## 🔥 Hot Reload

While the app is running, make changes and press:
- `r` - Hot reload (instant updates)
- `R` - Hot restart (full restart)
- `q` - Quit

## 📄 License

This project is open source and available for educational purposes.

## 🤝 Contributing

Feel free to fork this project and submit pull requests!

For questions or suggestions, please open an issue in the repository.
