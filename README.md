# Wallpaper Selector Desktop App

A beautiful desktop wallpaper selector application built with Flutter for Windows.

##  Features

- Browse wallpapers by categories (Nature, Abstract, Animals, Architecture, Minimal, Cars)
- Search functionality
- Sort by Newest, Popular, or Featured
- Favorites system
- Dark/Light theme toggle
- Responsive desktop layout
- Smooth animations and hover effects

##  Screenshots

[Add screenshots here]

##  Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Windows 10/11
- Visual Studio 2022 with Desktop development with C++ workload

### Installation

1. Clone the repository:
```bash
git clone https://github.com/kingshhub/hng-desktop-app
cd wallpaper_selector_desktop
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run -d windows
```

### Building Release APK
```bash
flutter build windows --release
```

The release build will be in `build/windows/runner/Release/`

## 📁 Project Structure
````
lib/
├── core/           # Constants and utilities
├── models/         # Data models
├── providers/      # State management (Provider)
├── screens/        # UI screens
├── widgets/        # Reusable widgets
└── data/          # Dummy data
````

## 🎥 Demo Video

[Link to demo video]

## 📦 Download

[Direct download link to release build]

## 🎨 Figma Design

https://www.figma.com/design/WnHFPfZ7uW2vxy4sHqtb12/MOBILE-WALLPAPER-SELECTOR?node-id=0-1&p=f&t=eBsANoqqdJwcLhL8-0

## 🛠️ Built With

- Flutter
- Provider (State Management)
- Material Design 3

## 👨‍💻 Author

Kingsley Simeon - https://github.com/kingshhub/
## 📄 License

This project is licensed under the MIT License.
````

---

## **Setup Instructions:**

1. **Create Flutter Project:**
````bash
   flutter create wallpaper_selector_desktop
   cd wallpaper_selector_desktop
````

2. **Replace pubspec.yaml** with the one provided above

3. **Create folder structure** exactly as shown

4. **Copy all code files** into their respective locations

5. **Export and add assets** from Figma as described

6. **Run the app:**
````bash
   flutter pub get
   flutter run -d windows
````

7. **Build release:**
````bash
   flutter build windows --release