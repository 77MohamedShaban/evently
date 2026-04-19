# Evently 📅

**Evently** is a robust, modern event management application built with Flutter and Firebase. It provides users with a seamless experience for discovering, creating, and managing events, featuring real-time updates, multi-language support, and a highly customizable UI.

<p align="center">
  <img src="https://github.com/user-attachments/assets/8aee3b13-8714-4026-b54c-4228ed4dabe2" height="350"/>
  <img src="https://github.com/user-attachments/assets/f117e795-3eec-454b-aa14-292b5eeb65a8" height="350"/>
  <img src="https://github.com/user-attachments/assets/7a358ed9-0a3d-4aed-9578-287958125fea" height="350"/>
  <img src="https://github.com/user-attachments/assets/dd26077a-31fe-4edf-805a-a1ee43b41bbd" height="350"/>
<img src="https://github.com/user-attachments/assets/2373efca-8a05-4eb8-b170-c9b9cf9fe9d4"  height="350"/>
<img src="https://github.com/user-attachments/assets/2ab67787-c567-41c8-aab1-ce3bcfb0d57a"height="350"/>
<img src="https://github.com/user-attachments/assets/0c8cd275-ec7c-47ec-92c4-32c24d0d0784" height="350" />
<img src="https://github.com/user-attachments/assets/cfc7c70e-ff47-4cc7-bd19-464a234e4e3e" height="350"/>
<img src="https://github.com/user-attachments/assets/76542dea-825b-4226-90f5-9738e05773e4" height="350"/>
<img src="https://github.com/user-attachments/assets/88f3791f-b397-45d5-bd35-f7b5562ae171" height="350"/>
<img src="https://github.com/user-attachments/assets/20722c5f-5e0e-4405-9967-01d002db511a" height="350"/>
</p>

## 🎬 Demo

👉 Watch Demo Video: https://www.linkedin.com/posts/mohamed-shaban-480019398_flutter-firebase-mobiledevelopment-activity-7451430894034153472-FXQ4?utm_source=share&utm_medium=member_desktop&rcm=ACoAAGGI0GABNB-j_SY7kBI5UbRrqZX0uGYNWw8
<div align="center">
  <video src="assets/ezyZip.mp4" width="300" controls muted autoplay loop>
  </video>
</div>

---

## ✨ Key Features

- **🔐 Secure Authentication**
  - Email/Password Sign-up and Login.
  - **Google Sign-In** integration for quick access.
  - Password recovery via Firebase Auth.
- **📅 Event Management (CRUD)**
  - Create events with titles, descriptions, categories, and specific dates.
  - Edit or delete your own events.
  - View event details with an intuitive UI.
- **🏠 Personalized Dashboard**
  - Filter events by category (e.g., Sport, Birthday, Meeting, etc.).
  - Real-time event listing using Cloud Firestore.
- **❤️ Favorites & My Events**
  - Save events to a personalized favorites list.
  - Dedicated tab to manage events you created.
- **🎨 Dynamic Theming**
  - Fully implemented **Light and Dark modes**.
  - Persists user theme preference using `shared_preferences`.
- **🌍 Localization (i18n)**
  - Full support for **English** and **Arabic**.
  - RTL (Right-to-Left) layout support for Arabic users.
- **🔔 Real-time Notifications**
  - Push notifications via **Firebase Cloud Messaging (FCM)**.
  - Local notifications for foreground alerts using `flutter_local_notifications`.
- **🚀 Smooth Onboarding**
  - Engaging onboarding flow for new users using `flutter_animate`.
  - Custom splash screen with `flutter_native_splash`.

---

## 🛠️ Tech Stack

- **Frontend**: [Flutter SDK](https://flutter.dev/) (Dart)
- **Backend**: [Firebase](https://firebase.google.com/)
    - **Firestore**: Real-time NoSQL database.
    - **Authentication**: Secure user identity management.
    - **Cloud Messaging**: Cross-platform messaging solutions.
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Localization**: [Easy Localization](https://pub.dev/packages/easy_localization)
- **Local Storage**: [Shared Preferences](https://pub.dev/packages/shared_preferences)
- **UI Components**: 
    - [Flutter Animate](https://pub.dev/packages/flutter_animate) (Animations)
    - [Flutter SVG](https://pub.dev/packages/flutter_svg) (Vector graphics)
    - [Image Picker](https://pub.dev/packages/image_picker) (Gallery/Camera access)

---

## 📁 Project Structure

```text
lib/
├── core/               # Reusable utilities, themes, and constants
│   ├── remote/         # Local storage (PrefsManager)
│   ├── resources/      # AppTheme, Colors, Assets, and Strings managers
│   └── reusable_component/ # Custom UI widgets used across the app
├── model/              # Data models (Event, User, etc.)
├── providers/          # State management (ThemeProvider, UserProvider)
├── services/           # External services (FCM service)
├── ui/                 # UI Screens and feature-specific widgets
│   ├── auth/           # Login, SignUp, ForgetPassword
│   ├── home/           # Dashboard and Tabs (Home, Favorite, Profile)
│   ├── events/         # Add, Edit, and Details screens
│   └── onboarding/     # Splash and Onboarding flow
└── main.dart           # Application entry point
```

---

## ⚙️ Setup & Installation

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
- [Firebase account](https://console.firebase.google.com/).
- Android Studio / VS Code with Flutter extensions.

### Steps
1. **Clone the repo**
   ```bash
   git clone https://github.com/your-username/evently.git
   cd evently
   ```
2. **Install dependencies**
   ```bash
   flutter pub get
   ```
3. **Firebase Configuration**
    - Create a new project in the Firebase Console.
    - Enable **Authentication** (Email/Password, Google).
    - Create a **Firestore Database**.
    - Run `flutterfire configure` to generate `firebase_options.dart`.
4. **Run the app**
   ```bash
   flutter run
   ```

---

## 🤝 Contribution

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the Project.
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`).
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the Branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

---

Made with ❤️ by [Mohamed Shaban]
