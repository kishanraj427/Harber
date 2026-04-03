# Harber

[![CI](https://github.com/kishanraj427/Harber/actions/workflows/ci.yml/badge.svg)](https://github.com/kishanraj427/Harber/actions/workflows/ci.yml)

A Flutter-based salon booking application that lets users discover nearby salons, book appointments, and pay seamlessly via UPI.

## Features

- **Onboarding** - Guided introduction slides for new users
- **Authentication** - Email/password signup and login with Firebase Auth
- **Salon Discovery** - Browse and search salons by location with ratings and images
- **Appointment Booking** - Select date and time slots with an interactive calendar
- **UPI Payments** - Pay directly through installed UPI apps (Google Pay, PhonePe, etc.)
- **Upcoming Appointments** - Real-time sync of booked appointments on the home screen
- **Animations** - Lottie splash screen and staggered list animations throughout

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter (Dart) |
| State Management | GetX |
| Authentication | Firebase Auth |
| Database | Cloud Firestore |
| Storage | Firebase Storage |
| Payments | Flutter UPI India |
| Animations | Lottie, Flutter Staggered Animations |
| UI Components | Calendar Date Picker 2, Flutter Rating Bar |

## Project Structure

```
lib/
├── main.dart                          # App entry point & splash screen
├── app_color.dart                     # Color palette constants
├── objects/
│   └── salon_class.dart               # Salon data model
└── screens/
    ├── slide_screen/                  # Onboarding carousel
    │   ├── slide_screen.dart
    │   └── slide_controller.dart
    ├── signup_screen/                 # User registration
    │   ├── signup_screen.dart
    │   └── get_singup.dart
    ├── login_screen/                  # User login
    │   ├── login_screen.dart
    │   └── get_login.dart
    ├── home_screen/                   # Salon listing & search
    │   ├── home_screen.dart
    │   └── home_screen_controller.dart
    ├── booking_screen/                # Date & time selection
    │   ├── booking_screen.dart
    │   └── booking_controller.dart
    └── payment_screen/                # Service selection & UPI payment
        ├── payment_screen.dart
        └── payment_controller.dart
```

## Getting Started

### Prerequisites

- Flutter SDK (>=3.41.0)
- A Firebase project with Auth, Firestore, and Storage enabled
- Android Studio / VS Code with Flutter plugins

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/harber.git
   cd harber
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Firebase:
   - Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
   - Add your Android/iOS app and download the config files
   - Place `google-services.json` in `android/app/`
   - Place `GoogleService-Info.plist` in `ios/Runner/`

4. Run the app:
   ```bash
   flutter run
   ```

## Firebase Data Structure

```
Firestore
├── salons/
│   └── {state}/
│       └── {city}/ (subcollection)
│           └── {salon_doc} → { name, image, loc, rate }
│
└── users/
    └── {email}/ → { name, email, uid }
        └── booking/ (subcollection)
            └── {timestamp} → { name, loc, date, time, service }
```

## Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| get | ^4.7.2 | State management & navigation |
| firebase_core | ^3.12.1 | Firebase initialization |
| firebase_auth | ^5.5.1 | User authentication |
| cloud_firestore | ^5.6.5 | Database |
| firebase_storage | ^12.4.1 | File storage |
| flutter_upi_india | ^1.0.1 | UPI payment integration |
| lottie | ^3.3.1 | Lottie animations |
| flutter_staggered_animations | ^1.1.1 | List animations |
| flutter_rating_bar | ^4.0.1 | Star ratings |
| calendar_date_picker2 | ^1.1.8 | Date picker |
| scroll_to_index | ^3.0.1 | Programmatic scrolling |
| flutter_svg | ^2.0.16 | SVG rendering |
| http | ^1.3.0 | HTTP client |

## Testing

Run all tests:

```bash
flutter test
```

| Test File | Tests | Covers |
|-----------|-------|--------|
| `app_color_test.dart` | 5 | Color values and opacity |
| `salon_class_test.dart` | 4 | Salon model instantiation |
| `booking_controller_test.dart` | 10 | Time slot selection, date, initial state |
| `slide_controller_test.dart` | 4 | Slide index navigation |
| `payment_controller_test.dart` | 12 | Services, prices, service selection, state |
| `signup_controller_test.dart` | 6 | Form fields, password visibility, loading state |
| `login_controller_test.dart` | 6 | Form fields, password visibility, loading state |

## CI/CD

GitHub Actions runs automatically on every **push to main** and **pull request to main**:

| Job | Description |
|-----|-------------|
| **Analyze** | Runs `flutter analyze` for static code analysis |
| **Test** | Runs all 49 unit tests via `flutter test` |
| **Build** | Builds debug APK (runs after Analyze and Test pass) |

The build artifact (debug APK) is uploaded and available for download from the workflow run.

Workflow config: [`.github/workflows/ci.yml`](.github/workflows/ci.yml)

## Documentation

- [Architecture Overview](docs/ARCHITECTURE.md)
- [Diagrams (Mermaid)](docs/DIAGRAMS.md)

## Screenshots

![Group 36](https://user-images.githubusercontent.com/62000613/221427323-9afdbf0a-3af1-41ee-9a5e-c71e1ee98231.png)

### Splash Screen

![Splash Screen](https://user-images.githubusercontent.com/62000613/221428599-cb466f50-86f4-4e05-9885-2eb42de8655a.gif)

### SignUp / LogIn

![Login](https://user-images.githubusercontent.com/62000613/221428641-aed6c5ea-a7ed-454e-8a49-6a7fbca42ded.gif)

### Booking & Payment

![Payment Screen](https://user-images.githubusercontent.com/62000613/221429443-69d2d076-c237-4347-a9da-e5c2a9a8733d.gif)

## License

This project is for educational and demonstration purposes.
